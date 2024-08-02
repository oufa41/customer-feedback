/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 08-02-2024
 * @last modified by  : Ahmed Abdelraouf
 **/

public class CustomerWrapper {
  public Customer__c customer { get; set; }
  public List<Feedback__c> feedbacks { get; set; }
  public Integer feedbacksSize { get; set; }

  public CustomerWrapper(Customer__c customer) {
    this.customer = customer;
    this.feedbacks = customer.Feedbacks__r;
    this.feedbacksSize = feedbacks.size();
  }
}
