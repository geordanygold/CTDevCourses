trigger OrderItemTrigger on OrderItem__c (after insert) {

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            OrderItemTriggerHandler.sendEmailOnNewOrder(Trigger.new);
            System.debug('Emails sent');
        }
    }
}