/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 07-30-2024
 * @last modified by  : Ahmed Abdelraouf
 **/
public class FeedbackService {
  private static final String OVERDUE_STATUS = 'Overdue';
  private static FeedbackService instance = null;
  private CustomerRepository customerRepositoryInstance;

  private FeedbackRepository feedbackRepositoryInstance;

  //private constructor to avoid creating an instance anywhere outside of this class
  private FeedbackService() {
    customerRepositoryInstance = CustomerRepository.getInstance();
    feedbackRepositoryInstance = FeedbackRepository.getInstance();
  }
  public static FeedbackService getInstance() {
    if (instance == null) {
      instance = new FeedbackService();
    }
    return instance;
  }

  public void manageNotFoundCustomer(List<Feedback__c> feedbacks) {
    List<Feedback__c> feedbacksToUpdate = new List<Feedback__c>();

    Set<String> emailAddresses = new Set<String>();
    for (Feedback__c feedback : feedbacks) {
      if (feedback.Submitted_Email__c != null) {
        emailAddresses.add(feedback.Submitted_Email__c);
      }
    }

    Map<String, Customer__c> emailToCustomerMap = new Map<String, Customer__c>();
    List<Customer__c> customersByEmail = customerRepositoryInstance.findCustomersByEmails(
      emailAddresses
    );
    for (Customer__c customer : customersByEmail) {
      emailToCustomerMap.put(customer.Contact__r.Email, customer);
    }

    Customer__c defaultCustomer = customerRepositoryInstance.findDefualtCustomer();

    for (Feedback__c feedback : feedbacks) {
      Feedback__c feedbackUpdate = new Feedback__c(Id = feedback.Id);

      if (
        feedback.Submitted_Email__c != null &&
        emailToCustomerMap.get(feedback.Submitted_Email__c) != null
      ) {
        feedbackUpdate.Customer__c = emailToCustomerMap.get(
            feedback.Submitted_Email__c
          )
          .Id;
      } else {
        feedbackUpdate.Customer__c = defaultCustomer.Id;
      }
      feedbacksToUpdate.add(feedbackUpdate);
    }

    if (!feedbacksToUpdate.isEmpty()) {
      update feedbacksToUpdate;
    }
  }

  public List<Feedback__c> updateNotReviewd(List<Feedback__c> feedbacks) {
    List<Feedback__c> feedbackToUpdate = new List<Feedback__c>();

    for (Feedback__c feedback : feedbacks) {
      feedback.Status__c = OVERDUE_STATUS;
      feedbackToUpdate.add(feedback);
    }

    if (!feedbackToUpdate.isEmpty()) {
      update feedbackToUpdate;
    }
    return feedbacks;
  }
}
