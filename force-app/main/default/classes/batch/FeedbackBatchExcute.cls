/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 07-31-2024
 * @last modified by  : Ahmed Abdelraouf
 **/
public class FeedbackBatchExcute {
  public static void excuteNotReviewdBatches(Integer numberOfBatches) {
    Database.executeBatch(new FeedbackNotReviewedBatch(), 10);
  }
}