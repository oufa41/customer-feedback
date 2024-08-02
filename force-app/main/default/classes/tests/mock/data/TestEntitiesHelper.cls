/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 07-30-2024
 * @last modified by  : Ahmed Abdelraouf
 **/
@isTest
public class TestEntitiesHelper {
  public static Account newAccount(String name) {
    Account account = new Account();
    account.Name = name;
    return Account;
  }

  public static contact newContact(
    String lastName,
    String email,
    String accountId
  ) {
    Contact contact = new Contact();
    contact.lastName = lastName;
    contact.email = email;
    contact.AccountId = accountId;
    return contact;
  }
  public static Customer__c newCustomer(
    String name,
    String contactId,
    Boolean isDefaultCustomer
  ) {
    Customer__c customer = new Customer__c();
    customer.Name = name;
    customer.Contact__c = contactId;
    customer.Default_Customer__c = isDefaultCustomer;
    return customer;
  }
  public static Feedback__c newFeedback(
    Datetime submittedDate,
    String submittedEmail
  ) {
    Feedback__c feedback = new Feedback__c();
    feedback.Date_Submitted__c = submittedDate;
    feedback.Submitted_Email__c = submittedEmail;
    return feedback;
  }
  public static Feedback__c newFeedback(
    Datetime submittedDate,
    String submittedEmail,
    String status,
    Datetime lastReviewedDate
  ) {
    Feedback__c feedback = new Feedback__c();
    feedback.Date_Submitted__c = submittedDate;
    feedback.Submitted_Email__c = submittedEmail;
    feedback.Status__c = status;
    feedback.LastReviewedDate__c = lastReviewedDate;
    return feedback;
  }
}