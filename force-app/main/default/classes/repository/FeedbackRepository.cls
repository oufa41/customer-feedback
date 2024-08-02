/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 07-29-2024
 * @last modified by  : Ahmed Abdelraouf
 **/
public class FeedbackRepository {
  private static FeedbackRepository instance = null;

  //private constructor to avoid creating an instance anywhere outside of this class
  private FeedbackRepository() {
  }
  public static FeedbackRepository getInstance() {
    if (instance == null) {
      instance = new FeedbackRepository();
    }
    return instance;
  }
}