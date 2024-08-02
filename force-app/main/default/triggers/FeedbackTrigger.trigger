/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 07-29-2024
 * @last modified by  : Ahmed Abdelraouf
 **/
trigger FeedbackTrigger on Feedback__c(after insert) {
  if (Trigger.isAfter) {
    if (Trigger.isInsert) {
      FeedbackTriggerHandler.onAfterInsert(Trigger.new);
    }
  }

}
// trigger FeedbackTrigger on Feedback__c(after insert) {
//   // List to store Feedback records to update
//   List<Feedback__c> feedbackToUpdate = new List<Feedback__c>();

//   // Collect all email addresses from the inserted Feedback records
//   Set<String> emailAddresses = new Set<String>();
//   for (Feedback__c feedback : Trigger.new) {
//     if (feedback.Submitted_Email__c != null) {
//       emailAddresses.add(feedback.Submitted_Email__c);
//     }
//   }

//   // Query related Customer records based on the collected email addresses
//   Map<String, Customer__c> emailToCustomerMap = new Map<String, Customer__c>();
//   for (Customer__c customer : [
//     SELECT Id, Contact__r.Email
//     FROM Customer__c
//     WHERE Contact__r.Email IN :emailAddresses
//   ]) {
//     emailToCustomerMap.put(customer.Contact__r.Email, customer);
//   }

//   // Query for the default Customer record
//   Customer__c defaultCustomer = [
//     SELECT Id
//     FROM Customer__c
//     WHERE Default_Customer__c = TRUE
//     LIMIT 1
//   ];

//   // Iterate over the Feedback records and assign the related Customer
//   for (Feedback__c feedback : Trigger.new) {
//     Feedback__c feedbackUpdate = new Feedback__c(Id = feedback.Id);

//     if (
//       feedback.Submitted_Email__c != null &&
//       emailToCustomerMap.containsKey(feedback.Submitted_Email__c)
//     ) {
//       feedback.Customer__c = emailToCustomerMap.get(feedback.Submitted_Email__c)
//         .Id;
//     } else {
//       feedback.Customer__c = defaultCustomer.Id;
//     }
//     feedbackToUpdate.add(feedback);
//   }

//   // Update the Feedback records
//   if (!feedbackToUpdate.isEmpty()) {
//     update feedbackToUpdate;
//   }
// }