/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 08-02-2024
 * @last modified by  : Ahmed Abdelraouf
 **/
@isTest
public class FeedbackDatatableControllerTest {
  @isTest
  public static void testGetQuery() {
    DateTime lastReviewedDateTime = DateTime.now().addDays(-31);

    List<Feedback__c> feedbacks = TestEntities.createFeedbackList(
      lastReviewedDateTime,
      'test@gmail.com'
    );

    FeedbackWrapper feedbackWrapper = FeedbackDatatableController.getFeedback(
      null,
      0,
      2
    );

    System.assertEquals(
      5,
      feedbackWrapper.totalRecords,
      'Total Recoerds should be equals 5'
    );
    System.assertEquals(
      2,
      feedbackWrapper.feedbacks.size(),
      'Total Recoerds should be equals 2'
    );
  }
}