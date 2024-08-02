/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 08-02-2024
 * @last modified by  : Ahmed Abdelraouf
 **/
public class NotifyInternalUserMetadataService {
  private static NotifyInternalUserMetadataService instance = null;

  //private constructor to avoid creating an instance anywhere outside of this class
  private NotifyInternalUserMetadataService() {
  }
  public static NotifyInternalUserMetadataService getInstance() {
    if (instance == null) {
      instance = new NotifyInternalUserMetadataService();
    }
    return instance;
  }

  public Map<String, String> mapEmailTemplatesTeamNamesByProcessName(
    String processName
  ) {
    // List<Notify_Internal_User__mdt> allValues = Notify_Internal_User__mdt.getAll()
    //   .values();
    Map<String, String> emailTemplatesByTeamNames = new Map<String, String>();
    List<Notify_Internal_User__mdt> listNotifyUserByProcess = [
      SELECT Id, Team_Name__c, Email_Template_Name__c
      FROM Notify_Internal_User__mdt
      WHERE Process_Name__c = :processName
    ];
    for (
      Notify_Internal_User__mdt notifyInternalUser : listNotifyUserByProcess
    ) {
      emailTemplatesByTeamNames.put(
        notifyInternalUser.Team_Name__c,
        notifyInternalUser.Email_Template_Name__c
      );
    }

    return emailTemplatesByTeamNames;
  }
}
