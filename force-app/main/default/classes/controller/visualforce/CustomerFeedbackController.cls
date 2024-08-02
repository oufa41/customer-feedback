/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 08-02-2024
 * @last modified by  : Ahmed Abdelraouf
 **/
public class CustomerFeedbackController {
  public List<CustomerWrapper> customers { get; set; }
  public Integer totalRecords { get; set; }
  public Integer pageSize { get; set; }
  public Integer pageNumber { get; set; }
  public String searchQuery { get; set; }

  public CustomerFeedbackController() {
    pageSize = 1;
    pageNumber = 1;
    searchQuery = '';
    fetchCustomers();
  }

  public void fetchCustomers() {
    // SOSL for search functionality
    if (searchQuery != null && !searchQuery.equals('')) {
      List<List<SObject>> searchResults = [
        FIND :searchQuery
        IN ALL FIELDS
        RETURNING Customer__c(Id, Name, Customer_Email__c)
      ];
      if (!searchResults.isEmpty() && !searchResults[0].isEmpty()) {
        List<Customer__c> customerList = (List<Customer__c>) searchResults[0];
        customers = wrapCustomers(customerList);
        totalRecords = customers.size();
      } else {
        customers = new List<CustomerWrapper>();
        totalRecords = 0;
      }
    } else {
      totalRecords = [SELECT COUNT() FROM Customer__c];
      List<Customer__c> customerList = [
        SELECT
          Id,
          Name,
          Customer_Email__c,
          (
            SELECT Id, Status__c, Date_Submitted__c
            FROM Feedbacks__r
            ORDER BY Date_Submitted__c DESC
          )
        FROM Customer__c
        ORDER BY Name
        LIMIT :pageSize
        OFFSET :((pageNumber - 1) * pageSize)
      ];
      customers = wrapCustomers(customerList);
    }
  }

  public List<CustomerWrapper> wrapCustomers(List<Customer__c> customerList) {
    List<CustomerWrapper> customerWrappers = new List<CustomerWrapper>();
    for (Customer__c customer : customerList) {
      customerWrappers.add(new CustomerWrapper(customer));
    }
    return customerWrappers;
  }

  public void nextPage() {
    if ((pageNumber * pageSize) < totalRecords) {
      pageNumber++;
      fetchCustomers();
    }
  }

  public void previousPage() {
    if (pageNumber > 1) {
      pageNumber--;
      fetchCustomers();
    }
  }

  public void search() {
    pageNumber = 1;
    fetchCustomers();
  }
}
