/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 08-02-2024
 * @last modified by  : Ahmed Abdelraouf
 **/
@isTest
public class CustomerFeedbackControllerTest {
  @isTest
  public static void testFetchCustomersWithSearch() {
    Customer__c defaultCustomer = TestEntities.createDefualtCustomer(
      'default@gmail.com'
    );
    Customer__c submittedCustomer = TestEntities.createDefualtCustomer(
      'notdefault@gmail.com'
    );
    Feedback__c feedbackToInsert = TestEntitiesHelper.newFeedback(
      Datetime.Now(),
      'notdefault@gmail.com'
    );
    CustomerFeedbackController ccustomerFeedbackController = new CustomerFeedbackController();
    System.runAs(new User(Id = UserInfo.getUserId())) {
      Test.startTest();
      ccustomerFeedbackController.searchQuery = 'test';
      ccustomerFeedbackController.pageSize = 1;
      ccustomerFeedbackController.pageNumber = 1;

      ccustomerFeedbackController.fetchCustomers();
      ccustomerFeedbackController.nextPage();
      ccustomerFeedbackController.previousPage();
      ccustomerFeedbackController.search();
      Test.stopTest();

      List<Customer__c> customersFromSOQL = [
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
        WHERE Name LIKE '%test%'
        ORDER BY Name
        LIMIT 2
      ];

      List<CustomerWrapper> customersFromController = ccustomerFeedbackController.customers;

      System.assertEquals(
        customersFromSOQL.size(),
        customersFromController.size()
      );
    }
  }
}
