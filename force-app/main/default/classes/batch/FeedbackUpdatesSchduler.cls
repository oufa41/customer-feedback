/**
 * @description       : 
 * @author            : Ahmed Abdelraouf
 * @group             : 
 * @last modified on  : 08-02-2024
 * @last modified by  : Ahmed Abdelraouf
**/
public class FeedbackUpdatesSchduler implements Schedulable {
  public static void scheduleIt() {
    System.schedule(
      'Update Feedback at the begining of  each hour',
      '0 0 * * * ?',
      new FeedbackUpdatesSchduler()
    );
  }

  public void execute(SchedulableContext sc) {
    // This is good practice if you are likely to be processing a
    // lot of records at a time
    FeedbackBatchExcute.excuteNotReviewdBatches(10);
  }
}