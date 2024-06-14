@isTest
public class SiteLoginController_Test {

    @testSetup 
    static void Setup(){
        // Create Account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Create Contact
        Contact testContact = new Contact(
            FirstName = 'Test',
            LastName = 'Contact',
            Email = 'test.contact@example.com',
            AccountId = testAccount.Id
        );
        insert testContact;
        // Trigger to create user should execute now
    }

    @isTest
    static void testFirstLoginSuccess() {
        // Query the newly created User
        User testUser = [SELECT Id, Username, First_Time__c, Temp_Password__c FROM User WHERE Email = 'test.contact@example.com' LIMIT 1];
        testUser.Temp_Password__c = '1123testingWelcome123';
        update testUser;

        System.setPassword(testUser.Id, '1123testingWelcome123');

        // Start test
        Test.startTest();

        String result = SiteLoginController.loginCheck(testUser.Username, '1123testingWelcome123');
        
        Assert.areEqual('FirstLogin', result);
        Test.stopTest();

    }

    @isTest
    static void testFirstLoginFailure() {
        // Query the newly created User
        User testUser = [SELECT Id, Username, First_Time__c, Temp_Password__c FROM User WHERE Email = 'test.contact@example.com' LIMIT 1];
        
        System.setPassword(testUser.Id, '1123testingWelcome123');

        // Start test
        Test.startTest();

        String result = SiteLoginController.loginCheck(testUser.Username, '1123testingWRONGpass');
        
        Assert.areEqual('Failure', result);
        Test.stopTest();

    }


    @isTest
    static void testSubsequentLoginSuccess() {
        // Query the newly created User
        User testUser = [SELECT Id, Username, First_Time__c, Temp_Password__c FROM User WHERE Email = 'test.contact@example.com' LIMIT 1];
        testUser.First_Time__c = 0;
        update testUser;
        System.setPassword(testUser.Id, '1123testingWelcome123');

        // Start test
        Test.startTest();

        String result = SiteLoginController.loginCheck(testUser.Username, '1123testingWelcome123');
        
        Assert.areEqual('Failure', result);
        Test.stopTest();
    }


    @isTest
    static void testSubsequentLoginFailure() {
        // Query the newly created User
        User testUser = [SELECT Id, Username, First_Time__c, Temp_Password__c FROM User WHERE Email = 'test.contact@example.com' LIMIT 1];
        testUser.First_Time__c = 0;
        update testUser;
        System.setPassword(testUser.Id, '1123testingWelcome123');

        // Start test
        Test.startTest();

        String result = SiteLoginController.loginCheck(testUser.Username, '1123testingWRONGpass');
        
        Assert.areEqual('Failure', result);
        Test.stopTest();

    }



}