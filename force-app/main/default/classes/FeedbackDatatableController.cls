/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 08-02-2024
 * @last modified by  : Ahmed Abdelraouf
 **/
public class FeedbackDatatableController {
  @AuraEnabled(cacheable=true)
  public static FeedbackWrapper getFeedback(
    String statusFilter,
    Integer offset,
    Integer limitNo
  ) {
    System.debug('statusFilter: ' + statusFilter);
    System.debug('offset: ' + offset);
    System.debug('limitNo: ' + limitNo);

    String statusClause = (statusFilter != null &&
      statusFilter != '')
      ? ' AND Status__c = :statusFilter'
      : '';
    String queryFilter = 'WHERE Status__c != NULL ' + statusClause;
    String query =
      'SELECT ID,Customer_Email__c, Date_Submitted__c, Feedback_Content__c, LastReviewedDate__c, Status__c, Customer__r.Contact__r.Name FROM Feedback__c ' +
      queryFilter +
      ' ORDER BY Date_Submitted__c DESC';
    query += '  LIMIT :limitNo OFFSET :offset';

    String countQuery = 'SELECT COUNT() FROM Feedback__c ' + queryFilter;

    List<Feedback__c> feedbackList = Database.query(query);
    List<FeedbackWrapper.FeedbackResponseWrapper> feedbacks = new List<FeedbackWrapper.FeedbackResponseWrapper>();
    for (Feedback__c feedback : feedbackList) {
      feedbacks.add(new FeedbackWrapper.FeedbackResponseWrapper(feedback));
    }
    Integer totalRecords = (Integer) Database.countQuery(countQuery);
    System.debug('totalRecords: ' + totalRecords);
    System.debug('feedbacks: ' + feedbacks);

    return new FeedbackWrapper(feedbacks, totalRecords);
  }
}
