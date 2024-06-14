public with sharing class AccountUserSettingsController {
    
    @AuraEnabled(cacheable=true)
    public static User getUserDetails(Id UserId) {
        try {
            return [SELECT Id, FirstName, LastName, Email, Phone, CommunityNickname FROM User WHERE Id = :UserId LIMIT 1];
        } catch (Exception e) {
            throw new AuraHandledException('Error retrieving user details: ' + e.getMessage());
        }
    }


    @AuraEnabled(cacheable=true)
    public static User getUserInfo(Id userId) {
        return [SELECT Id, FirstName, LastName, Email, Phone, CommunityNickname FROM User WHERE Id = :userId LIMIT 1];
    }


    @AuraEnabled(cacheable=true)
    public static Account getAccountDetails() {
        //User currentUser = [SELECT ContactId FROM User WHERE Id = :UserInfo.getUserId()];
        //Contact currentContact = [SELECT AccountId FROM Contact WHERE Id = :currentUser.ContactId];
        User currUserAccount = [SELECT Contact.AccountId FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1];

        return [SELECT Id, Name, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry FROM Account WHERE Id = :currUserAccount.Contact.AccountId LIMIT 1];
    }

    @AuraEnabled(cacheable=true)
    public static Contact getContactDetails() {
        User currentUser = [SELECT ContactId FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1];
        return [SELECT Id, FirstName, LastName, Email, Phone, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry FROM Contact WHERE Id = :currentUser.ContactId LIMIT 1];
        //return [SELECT Contact.Id, Contact.FirstName, Contact.LastName, Contact.Email, Contact.Phone, Contact.MailingStreet, Contact.MailingCity, Contact.MailingState, Contact.MailingPostalCode, Contact.MailingCountry FROM User WHERE Id = :UserInfo.getUserId()];
    }

    @AuraEnabled
    public static void updateUser(User user) {
        update user;
    }

    @AuraEnabled
    public static void updateAccount(Account account) {
        update account;
    }

    @AuraEnabled
    public static void updateContact(Contact contact) {
        update contact;
    }
}