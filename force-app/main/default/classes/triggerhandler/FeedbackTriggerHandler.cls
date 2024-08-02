/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 07-29-2024
 * @last modified by  : Ahmed Abdelraouf
 **/
public class FeedbackTriggerHandler {
  public static FeedbackService feedbackServiceInstance = FeedbackService.getInstance();

  public static void onAfterInsert(List<Feedback__c> feedbacks) {
    feedbackServiceInstance.manageNotFoundCustomer(feedbacks);
  }
}