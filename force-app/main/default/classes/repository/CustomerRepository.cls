/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 07-30-2024
 * @last modified by  : Ahmed Abdelraouf
 **/
public class CustomerRepository {
  private static CustomerRepository instance = null;
  @TestVisible
  private static final String EXCEPTION_MESSAGE_DEFAULT_CUSTOMER = 'Default customer not found.';

  //private constructor to avoid creating an instance anywhere outside of this class
  private CustomerRepository() {
  }
  public static CustomerRepository getInstance() {
    if (instance == null) {
      instance = new CustomerRepository();
    }
    return instance;
  }

  public Customer__c findDefualtCustomer() {
    List<Customer__c> customers = [
      SELECT Id, Name
      FROM Customer__c
      WHERE Default_Customer__c = TRUE
      LIMIT 1
    ];

    if (customers.isEmpty()) {
      throw new CustomerException(EXCEPTION_MESSAGE_DEFAULT_CUSTOMER);
    }

    return customers.get(0);
  }
  public List<Customer__c> findCustomersByEmails(Set<String> emails) {
    List<Customer__c> customers = [
      SELECT Id, Contact__r.Email
      FROM Customer__c
      WHERE Contact__r.Email IN :emails
    ];

    return customers;
  }

  public class CustomerException extends Exception {
  }
}
