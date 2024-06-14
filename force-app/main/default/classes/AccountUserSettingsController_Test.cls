@isTest
public with sharing class AccountUserSettingsController_Test {
    @testSetup
    static void setup() {
        // Create a test account
        Account testAccount = new Account(
            Name = 'Test Account',
            BillingStreet = '123 Test St',
            BillingCity = 'Testville',
            BillingState = 'CA',
            BillingPostalCode = '12345',
            BillingCountry = 'USA'
        );
        insert testAccount;

        // Create a test contact
        Contact testContact = new Contact(
            FirstName = 'Test',
            LastName = 'Contact',
            Email = 'testcontact@example.com',
            Phone = '123-456-7890',
            MailingStreet = '123 Test St',
            MailingCity = 'Testville',
            MailingState = 'CA',
            MailingPostalCode = '12345',
            MailingCountry = 'USA',
            AccountId = testAccount.id
        );
        insert testContact;

        Profile Profile = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        // Create a test user and link it to the test contact
        User testUser = new User(
            FirstName = 'Test',
            LastName = 'User',
            Email = 'testuser@example.com',
            Username = 'testuser@example.com.test',
            Alias = 'tuser',
            CommunityNickname = 'tuser',
            ProfileId = Profile.Id,
            ContactId = testContact.Id,
            TimeZoneSidKey = 'America/Los_Angeles', 
            LocaleSidKey = 'en_US', 
            EmailEncodingKey = 'UTF-8', 
            LanguageLocaleKey = 'en_US' 
        );
        
        insert testUser;
    }


    @isTest
    static void testGetUserDetails() {

        User testUser = [SELECT Id FROM User WHERE FirstName = 'Test' LIMIT 1];

        Test.startTest();
        User result = AccountUserSettingsController.getUserDetails(testUser.Id);
        Test.stopTest();

        Assert.areEqual(testUser.Id, result.Id);
        Assert.areEqual('Test', result.FirstName);
        Assert.areEqual('User', result.LastName);
        Assert.areEqual('testuser@example.com', result.Email);
    }

    @isTest
    static void testGetAccountDetails() {

        Account testAccount = [SELECT Id, Name, BillingStreet, BillingCity FROM Account WHERE Name = 'Test Account' LIMIT 1];

        Test.startTest();
        Account result = AccountUserSettingsController.getAccountDetails();
        Test.stopTest();

        Assert.areEqual(testAccount.Id, result.Id);
        Assert.areEqual('Test Account', result.Name);
        Assert.areEqual('123 Test St', result.BillingStreet);
        Assert.areEqual('Testville', result.BillingCity);
    }

    @isTest
    static void testGetContactDetails() {
        
        Contact testContact = [SELECT Id, FirstName, LastName, Email FROM Contact WHERE FirstName = 'Test' LIMIT 1];

        Test.startTest();
        Contact result = AccountUserSettingsController.getContactDetails();
        Test.stopTest();

        Assert.areEqual(testContact.Id, result.Id);
        Assert.areEqual('Test', result.FirstName);
        Assert.areEqual('Contact', result.LastName);
        Assert.areEqual('testcontact@example.com', result.Email);
    }

    @isTest
    static void testUpdateUser() {

        User testUser = [SELECT Id, FirstName FROM User WHERE FirstName = 'Test' LIMIT 1];
        testUser.FirstName = 'Updated';

        Test.startTest();
        AccountUserSettingsController.updateUser(testUser);
        Test.stopTest();

        User updatedUser = [SELECT FirstName FROM User WHERE Id = :testUser.Id];
        Assert.areEqual('Updated', updatedUser.FirstName);
    }

    @isTest
    static void testUpdateAccount() {

        Account testAccount = [SELECT Id, Name FROM Account WHERE Name = 'Test Account' LIMIT 1];

        testAccount.Name = 'Updated Account';

        Test.startTest();
        AccountUserSettingsController.updateAccount(testAccount);
        Test.stopTest();

        Account updatedAccount = [SELECT Name FROM Account WHERE Id = :testAccount.Id];
        Assert.areEqual('Updated Account', updatedAccount.Name);
    }

    @isTest
    static void testUpdateContact() {

        Contact testContact = [SELECT Id, FirstName FROM Contact WHERE FirstName = 'Test' LIMIT 1];

        testContact.FirstName = 'Updated';

        Test.startTest();
        AccountUserSettingsController.updateContact(testContact);
        Test.stopTest();

        Contact updatedContact = [SELECT FirstName FROM Contact WHERE Id = :testContact.Id];
        Assert.areEqual('Updated', updatedContact.FirstName);
    }
}