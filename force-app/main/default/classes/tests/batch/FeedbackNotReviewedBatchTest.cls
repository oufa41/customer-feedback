/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 07-30-2024
 * @last modified by  : Ahmed Abdelraouf
 **/
@isTest
public class FeedbackNotReviewedBatchTest {
  @isTest
  public static void testOverdueStatusFeedbacks() {
    DateTime lastReviewedDateTime = DateTime.now().addDays(-31);

    List<Feedback__c> feedbacks = TestEntities.createFeedbackList(
      lastReviewedDateTime,
      'test@gmail.com'
    );

    Test.startTest();
    FeedbackBatchExcute.excuteNotReviewdBatches(10);
    //ImportPortfolioBatches.contracts();
    Test.stopTest();

    List<Feedback__c> updatedList = [
      SELECT Id, Status__c
      FROM Feedback__c
      WHERE Status__c = 'Overdue'
    ];
    System.assertEquals(
      5,
      updatedList.size(),
      'The update feedbacks should be all list of size 5'
    );
  }
  @isTest
  public static void testNotUpdatedOverdueStatusFeedbacks() {
    DateTime lastReviewedDateTime = DateTime.now().addDays(-10);

    List<Feedback__c> feedbacks = TestEntities.createFeedbackList(
      lastReviewedDateTime,
      'test@gmail.com'
    );

    Test.startTest();
    FeedbackBatchExcute.excuteNotReviewdBatches(10);
    //ImportPortfolioBatches.contracts();
    Test.stopTest();

    List<Feedback__c> updatedList = [
      SELECT Id, Status__c
      FROM Feedback__c
      WHERE Status__c = 'Overdue'
    ];
    System.assertEquals(
      0,
      updatedList.size(),
      'No updated feedbacks should be all list of size 0'
    );
  }
}
