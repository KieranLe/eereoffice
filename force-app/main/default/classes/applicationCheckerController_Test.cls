@isTest
public with sharing class applicationCheckerController_Test {
   
    @testSetup
    static void setup() {
        Account testAccount = new Account(
            Name = 'Test Account',
            BillingStreet = '123 Test St',
            BillingCity = 'Testville',
            BillingState = 'CA',
            BillingPostalCode = '12345',
            BillingCountry = 'USA'
        );
        insert testAccount;

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
            AccountId = testAccount.Id
        );
        insert testContact;

        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User' LIMIT 1];
        User testUser = new User(
            FirstName = 'Test',
            LastName = 'User',
            Email = 'testuser@example.com',
            Username = 'testuser@example.com.test',
            Alias = 'tuser',
            CommunityNickname = 'tuser',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            ProfileId = p.Id,
            ContactId = testContact.Id
        );
        insert testUser;

        Opportunity testOpportunity = new Opportunity(
            Name = 'Test Opportunity',
            Description = 'Test Opportunity Description',
            Type = 'New Business',
            StageName = 'Prospecting',
            CloseDate = Date.today().addMonths(1),
            AccountId = testAccount.Id
        );
        insert testOpportunity;

        /*Case testCase = new Case(
            CaseNumber = '00001000',
            Subject = 'Test Case',
            Description = 'Test Case Description',
            Status = 'New',
            AccountId = testAccount.Id
        );
        insert testCase;*/

        Task testTask = new Task(
            Subject = 'Test Call',
            ActivityDate = Date.today(),
            WhatId = testOpportunity.Id
        );
        insert testTask;

        Event testEvent = new Event(
            Subject = 'Test Event',
            ActivityDate = Date.today(),
            WhatId = testOpportunity.Id
        );
        insert testEvent;

        /*EmailMessage testEmail = new EmailMessage(
            Subject = 'Test Email',
            CreatedDate = DateTime.now(),
            TextBody = 'Test Email Body',
            RelatedToId = testOpportunity.Id
        );
        insert testEmail;*/

        Task testCall = new Task(
            Subject = 'Test Call',
            ActivityDate = Date.today(),
            WhatId = testOpportunity.Id
        );
        insert testCall;

        /*ContentDocument testDocument = new ContentDocument(
            Title = 'Test Document',
            FileType = 'PDF',
            CreatedDate = DateTime.now()
        );
        insert testDocument;*/

        ContentDocumentLink testDocumentLink = new ContentDocumentLink(
            LinkedEntityId = testOpportunity.Id,
            //ContentDocumentId = testDocument.Id,
            ShareType = 'V',
            Visibility = 'AllUsers'
        );
        insert testDocumentLink;

        /*ContentDocument testDocument = new ContentDocument(
            Title = 'Test Document',
            FileType = 'PDF',
            CreatedDate = DateTime.now()
        );
        insert testDocument;*/
    }

    @isTest
    static void testGetAccountId() {
        User testUser = [SELECT Id, Contact.AccountId FROM User WHERE FirstName = 'Test' LIMIT 1];

        Test.startTest();
        User result = applicationCheckerController.getAccountId();
        Test.stopTest();

        Assert.areEqual(testUser.Id, result.Id);
        Assert.areEqual(testUser.Contact.AccountId, result.Contact.AccountId);
    }

    @isTest
    static void testGetRelatedOpportunity() {
        Opportunity testOpportunity = [SELECT Id, AccountId FROM Opportunity WHERE Name = 'Test Opportunity' LIMIT 1];

        Test.startTest();
        List<Opportunity> result = applicationCheckerController.getRelatedOpportunity(testOpportunity.AccountId);
        Test.stopTest();

        Assert.areEqual(1, result.size());
        Assert.areEqual(testOpportunity.Id, result[0].Id);
    }

    @isTest
    static void testGetStage() {
        Opportunity testOpportunity = [SELECT Id, StageName, AccountId FROM Opportunity WHERE Name = 'Test Opportunity' LIMIT 1];

        Test.startTest();
        List<Opportunity> result = applicationCheckerController.getStage(testOpportunity.AccountId);
        Test.stopTest();

        Assert.areEqual(1, result.size());
        Assert.areEqual('Prospecting', result[0].StageName);
    }

    @isTest
    static void testGetRelatedCases() {
        Case testCase = [SELECT Id, AccountId FROM Case WHERE CaseNumber = '00001000' LIMIT 1];

        Test.startTest();
        List<Case> result = applicationCheckerController.getRelatedCases(testCase.AccountId);
        Test.stopTest();

        Assert.areEqual(1, result.size());
        Assert.areEqual(testCase.Id, result[0].Id);
    }

    @isTest
    static void testGetTasks() {

        Task testTask = [SELECT Id, WhatId FROM Task WHERE Subject = 'Test Call' LIMIT 1];

        Test.startTest();
        List<Task> result = applicationCheckerController.getTasks(testTask.WhatId);
        Test.stopTest();

        Assert.areEqual(1, result.size());
        Assert.areEqual(testTask.Id, result[0].Id);
    }

    @isTest
    static void testGetEvents() {
        Event testEvent = [SELECT Id, WhatId FROM Event WHERE Subject = 'Test Event' LIMIT 1];

        Test.startTest();
        List<Event> result = applicationCheckerController.getEvents(testEvent.WhatId);
        Test.stopTest();

        Assert.areEqual(1, result.size());
        Assert.areEqual(testEvent.Id, result[0].Id);
    }

    @isTest
    static void testGetEmails() {
        EmailMessage testEmail = [SELECT Id, RelatedToId FROM EmailMessage WHERE Subject = 'Test Email' LIMIT 1];

        Test.startTest();
        List<EmailMessage> result = applicationCheckerController.getEmails(testEmail.RelatedToId);
        Test.stopTest();

        Assert.areEqual(1, result.size());
        Assert.areEqual(testEmail.Id, result[0].Id);
    }

    @isTest
    static void testGetCalls() {
        Task testCall = [SELECT Id, WhatId FROM Task WHERE Subject = 'Test Call' LIMIT 1];

        Test.startTest();
        List<Task> result = applicationCheckerController.getCalls(testCall.WhatId);
        Test.stopTest();

        Assert.areEqual(1, result.size());
        Assert.areEqual(testCall.Id, result[0].Id);
    }

    @isTest
    static void testGetNotesAndAttachments() {
        Opportunity testOpportunity = [SELECT Id FROM Opportunity WHERE Name = 'Test Opportunity' LIMIT 1];
        ContentDocumentLink testDocument = [SELECT Id, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId = :testOpportunity.Id LIMIT 1];

        Test.startTest();
        List<applicationCheckerController.ContentDocumentLinkWrapper> result = applicationCheckerController.getNotesAndAttachments(testOpportunity.id);
        Test.stopTest();

        Assert.areEqual(1, result.size());
        Assert.areEqual(testDocument.Id, result[0].Id);
    }

    @isTest
    static void testLinkContentDocument() {
        Opportunity testOpportunity = [SELECT Id FROM Opportunity WHERE Name = 'Test Opportunity' LIMIT 1];
        ContentDocumentLink testDocument = [SELECT Id, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId = :testOpportunity.Id LIMIT 1];

        Test.startTest();
        applicationCheckerController.linkContentDocument(testOpportunity.Id, testDocument.Id);
        Test.stopTest();

        ContentDocumentLink result = [SELECT Id FROM ContentDocumentLink WHERE LinkedEntityId = :testOpportunity.Id AND ContentDocumentId = :testDocument.Id LIMIT 1];
        System.assertNotEquals(null, result);
    }
}