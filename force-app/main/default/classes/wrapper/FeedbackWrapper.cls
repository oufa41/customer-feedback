/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 08-02-2024
 * @last modified by  : Ahmed Abdelraouf
 **/
public class FeedbackWrapper {
  @AuraEnabled
  public List<FeedbackResponseWrapper> feedbacks { get; set; }
  @AuraEnabled
  public Integer totalRecords { get; set; }

  public FeedbackWrapper(
    List<FeedbackResponseWrapper> feedbacks,
    Integer totalRecords
  ) {
    this.feedbacks = feedbacks;
    this.totalRecords = totalRecords;
  }

  public class FeedbackResponseWrapper {
    @AuraEnabled
    public String id { get; set; }
    @AuraEnabled
    public String feedbackText { get; set; }
    @AuraEnabled
    public DateTime dateSubmitted { get; set; }
    @AuraEnabled
    public String status { get; set; }
    @AuraEnabled
    public String customerName { get; set; }
    @AuraEnabled
    public String customerEmail { get; set; }

    public FeedbackResponseWrapper(Feedback__c feedback) {
      this.id = feedback.Id;
      this.feedbackText = feedback.Feedback_Content__c;
      this.dateSubmitted = feedback.Date_Submitted__c;
      this.status = feedback.Status__c;
      this.customerName = feedback.Customer__r.Contact__r.Name;
      this.customerEmail = feedback.Customer_Email__c;
    }
  }
}