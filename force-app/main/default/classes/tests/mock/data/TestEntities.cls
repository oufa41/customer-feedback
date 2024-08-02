/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 08-02-2024
 * @last modified by  : Ahmed Abdelraouf
 **/
@isTest
public class TestEntities {
  private static final string NEW_FEEDBACK_STATUS = 'New';
  public static Customer__c createDefualtCustomer(String email) {
    Account account = TestEntitiesHelper.newAccount('Tamara Test Account 1');
    insert account;
    Contact contact = TestEntitiesHelper.newContact(
      'Default Contact',
      email,
      account.Id
    );
    insert contact;
    Customer__c customer = TestEntitiesHelper.newCustomer(
      contact.lastName,
      contact.Id,
      true
    );
    insert customer;

    List<Customer__c> customers = new List<Customer__c>();
    customers.add(customer);
    Formula.recalculateFormulas(customers);
    return customer;
  }
  public static Customer__c createNotDefualtCustomer(String email) {
    Account account = TestEntitiesHelper.newAccount('Tamara Test Account 1');
    insert account;
    Contact contact = TestEntitiesHelper.newContact(
      'Not Default Contact',
      email,
      account.Id
    );
    insert contact;
    Customer__c customer = TestEntitiesHelper.newCustomer(
      contact.lastName,
      contact.Id,
      false
    );
    insert customer;

    List<Customer__c> customers = new List<Customer__c>();
    customers.add(customer);
    Formula.recalculateFormulas(customers);
    return customer;
  }

  public static List<Feedback__c> createFeedbackList(
    Datetime lastReviewedDate,
    String email
  ) {
    Account account = TestEntitiesHelper.newAccount('Tamara Test Account 1');
    insert account;
    Contact contact = TestEntitiesHelper.newContact(
      'Default Contact',
      email,
      account.Id
    );
    insert contact;
    Customer__c customer = TestEntitiesHelper.newCustomer(
      contact.lastName,
      contact.Id,
      true
    );
    insert customer;

    List<Customer__c> customers = new List<Customer__c>();
    customers.add(customer);
    Formula.recalculateFormulas(customers);

    List<Feedback__c> feedbacks = new List<Feedback__c>();
    for (Integer i = 0; i < 5; i++) {
      feedbacks.add(
        TestEntitiesHelper.newFeedback(
          Datetime.Now(),
          email,
          NEW_FEEDBACK_STATUS,
          lastReviewedDate
        )
      );
    }
    insert feedbacks;
    Formula.recalculateFormulas(feedbacks);

    return feedbacks;
  }
}