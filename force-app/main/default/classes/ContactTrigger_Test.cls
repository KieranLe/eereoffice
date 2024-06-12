@isTest
public class ContactTrigger_Test {

    @isTest
    static void testCreateCommunityUser() {
        // Create a test Account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Create a test Contact
        Contact testContact = new Contact(
            FirstName = 'Test',
            LastName = 'Contact',
            Email = 'test.contact@example.com',
            AccountId = testAccount.Id
        );
        insert testContact;

        // Query the newly created User
        User testUser = [SELECT Id, Email, ContactId FROM User WHERE ContactId = :testContact.Id LIMIT 1];
        
        // Validate the User was created and linked to the Contact
        Assert.areNotEqual(null, testUser);
        Assert.areEqual(testContact.Email, testUser.Email);
        Assert.areEqual(testContact.Id, testUser.ContactId);
    }

}