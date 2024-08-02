/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 08-02-2024
 * @last modified by  : Ahmed Abdelraouf
 **/
public class FeedbackNotReviewedBatch implements Database.Batchable<SObject>, Database.Stateful {
  private static final String METADATA_PROCESS_NAME = 'Feedback Not Reviewed Batch';
  private String query =
    'SELECT Id, Status__c, CreatedDate, LastReviewedDate__c ' +
    'FROM Feedback__c ' +
    'WHERE LastReviewedDate__c  < LAST_N_DAYS:30' +
    'AND Status__c != \'Overdue\'';

  public List<Id> overdueFeedbackIds;

  public FeedbackService feedbackServiceInstance = null;
  public NotifyInternalUserMetadataService notifyInternalUserMetadataServiceInstance = null;

  public FeedbackNotReviewedBatch() {
    feedbackServiceInstance = FeedbackService.getInstance();
    notifyInternalUserMetadataServiceInstance = NotifyInternalUserMetadataService.getInstance();
    overdueFeedbackIds = new List<Id>();
  }
  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator(query);
  }

  public void execute(
    Database.BatchableContext bc,
    List<Feedback__c> feedbacks
  ) {
    feedbackServiceInstance.updateNotReviewd(feedbacks);
    for (Feedback__c feedback : feedbacks) {
      overdueFeedbackIds.add(feedback.Id);
    }
  }

  public void finish(Database.BatchableContext bc) {
    sendEmailNotification(overdueFeedbackIds);
  }

  private void sendEmailNotification(List<Id> feedbackIds) {
    String emailSubject = 'Overdue Feedback Notification';
    String emailBody = 'The following feedback records have not been reviewed for more than 30 days and are marked as "Overdue":\n\n';

    for (Id feedbackId : feedbackIds) {
      emailBody += 'Feedback ID: ' + feedbackId + '\n';
    }

    List<User> adminUser = [
      SELECT Id
      FROM User
      WHERE Profile.Name = 'System Administrator'
      LIMIT 1
    ];

    EmailUtility.sendSingleEmail(emailSubject, emailBody, adminUser);

    Map<String, String> emailTemplateByTeamName = notifyInternalUserMetadataServiceInstance.mapEmailTemplatesTeamNamesByProcessName(
      METADATA_PROCESS_NAME
    );

    Map<ID, Group> groupsById = new Map<ID, Group>(
      [
        SELECT Id, Name
        FROM Group
        WHERE Name = :emailTemplateByTeamName.keySet() AND Type = 'Regular'
      ]
    );

    List<User> users = [
      SELECT Id, Name, Email
      FROM User
      WHERE
        Id IN (
          SELECT UserOrGroupId
          FROM GroupMember
          WHERE GroupId = :groupsById.keySet()
        )
    ];

    List<EmailTemplate> emailTempalte = [
      SELECT Id, Name, Subject, Body
      FROM EmailTemplate
      WHERE Name = 'Feedback Notification'
    ];
    EmailUtility.sendMassEmail(
      emailSubject,
      emailBody,
      users,
      emailTempalte.get(0).id
    );
  }
}
