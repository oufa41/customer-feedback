/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 08-03-2024
 * @last modified by  : Ahmed Abdelraouf
 **/
@isTest
private class FeedbackUpdatesSchdulerTest {
  @isTest
  public static void testFeedbackUpdatesSchduler() {
    // Schedule the class

    User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
    System.runAs(thisUser) {
      Test.startTest();
      FeedbackUpdatesSchduler.scheduleIt();
      Test.stopTest();
    }

    // Get the scheduled job
    List<CronTrigger> scheduledJobs = [
      SELECT Id
      FROM CronTrigger
      WHERE CronJobDetail.Name = 'Update Feedback at the begining of  each hour'
    ];

    // Assert that a job was scheduled
    System.assertEquals(1, scheduledJobs.size());
  }
}
