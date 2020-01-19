public with sharing class OrderItemTriggerHandler {
    public OrderItemTriggerHandler() {}

    public static void sendEmailOnNewOrder (List <OrderItem__c> newOrderItems){
        
        Integer orderItems = newOrderItems.size();
        system.debug('orderItems ' + orderItems);
        List <Messaging.SingleEmailMessage> mails = new List <Messaging.SingleEmailMessage>();
        List <String> toAddresses = new List <String>();

        List <User> shopAdmins = [SELECT Id, Username, Email
                                FROM User 
                                WHERE Profile.Name = 'Shop Admin'
                                AND IsActive = TRUE];
        system.debug('shopAdmins ' + shopAdmins);

        for( User shopAdmin : shopAdmins ){
            toAddresses.add(shopAdmin.Email);
            system.debug('shopAdmin.Email ' + shopAdmin.Email);
        }

        for( OrderItem__c newOrder : newOrderItems ){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setSubject('New Order Created : ' + newOrder.Id);
            mail.setPlainTextBody('New Order: ' + newOrder.Id +' has been created.');
            mail.setToAddresses(toAddresses);
            mail.setBccSender(false);
            mails.add(mail);
            system.debug('New Order Created : ' + newOrder.Id);
        }
        Messaging.sendEmail(mails);
        system.debug('Emails sent ' + mails);
    }
}