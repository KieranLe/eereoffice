
@isTest
public class ResetPasswordController_Test {

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
    static void testResetPassword() {

        User currUser = [SELECT Id, Email, Username FROM User WHERE Email = 'test.contact@example.com' LIMIT 1];
        System.setPassword(currUser.Id, 'veryTempPass123');

        // Start test
        Test.startTest();

        String result = ResetPasswordController.resetPassword(currUser.Username, '123testingWelcome123');
        
        Assert.areEqual('Success', result);
        Test.stopTest();

    }

    @isTest
    static void testResetPassword_InvalidPassword() {
        
        User currUser = [SELECT Id, Email, Username FROM User WHERE Email = 'test.contact@example.com' LIMIT 1];
        System.setPassword(currUser.Id, 'veryTempPass123');

        // Start test
        Test.startTest();

        String result = ResetPasswordController.resetPassword(currUser.Username, '');
        Assert.areEqual('Failure INVALID_NEW_PASSWORD: password length must be greater than 0', result);

        Test.stopTest();

    }
}