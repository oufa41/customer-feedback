/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 08-02-2024
 * @last modified by  : Ahmed Abdelraouf
 **/
public class EmailUtility {
  public static void sendSingleEmail(
    String subject,
    String body,
    List<User> currentUser
  ) {
    // Define the email
    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
    email.setSubject(subject);

    email.setTargetObjectId(currentUser.get(0).Id);

    email.setPlainTextBody(body);

    email.setSaveAsActivity(false);
    Messaging.SendEmailResult[] r = Messaging.sendEmail(
      new List<Messaging.SingleEmailMessage>{ email }
    );
  }
  public static void sendMassEmail(
    String subject,
    String body,
    List<User> users,
    String emailTempalateId
  ) {
    // Define the email
    Messaging.MassEmailMessage email = new Messaging.MassEmailMessage();
    List<String> userIds = new List<String>();
    for (User user : users) {
      userIds.add(user.Id);
    }
    System.debug(userIds);
    email.setTargetObjectIds(userIds);
    email.setTemplateId(emailTempalateId);
    email.setSaveAsActivity(false);
    Messaging.SendEmailResult[] r = Messaging.sendEmail(
      new List<Messaging.MassEmailMessage>{ email }
    );
  }
}
