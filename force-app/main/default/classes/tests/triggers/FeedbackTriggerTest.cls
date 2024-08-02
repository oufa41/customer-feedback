/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 07-30-2024
 * @last modified by  : Ahmed Abdelraouf
 **/
@isTest
public class FeedbackTriggerTest {
  public static final string ASSERT_MESSAGE_MATCHED_DEFAULT_CUSTOMER = 'Feedback record customer linked to defualt Customer';
  @isTest
  public static void testAssignDefaultCustomer() {
    Customer__c defaultCustomer = TestEntities.createDefualtCustomer(
      'default@gmail.com'
    );
    Feedback__c feedbackToInsert = TestEntitiesHelper.newFeedback(
      Datetime.Now(),
      'notdefault@gmail.com'
    );
    insert feedbackToInsert;
    Feedback__c feedbackAfterInsert = [
      SELECT Id, Customer__c
      FROM Feedback__c
      WHERE Id = :feedbackToInsert.Id
    ];

    System.assertEquals(
      defaultCustomer.Id,
      feedbackAfterInsert.Customer__c,
      ASSERT_MESSAGE_MATCHED_DEFAULT_CUSTOMER
    );
  }
  @isTest
  public static void testAssignSubmittedCustomer() {
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
    insert feedbackToInsert;
    Feedback__c feedbackAfterInsert = [
      SELECT Id, Customer__c
      FROM Feedback__c
      WHERE Id = :feedbackToInsert.Id
    ];

    System.assertEquals(
      submittedCustomer.Id,
      feedbackAfterInsert.Customer__c,
      ASSERT_MESSAGE_MATCHED_DEFAULT_CUSTOMER
    );
  }
}