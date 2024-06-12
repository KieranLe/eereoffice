// Create account
Account applicantacc = new Account(Name='HydroScience Technologies');
insert applicantacc;
ID applicantaccId = applicantacc.Id;

// Create a new contact
Contact applicant = new Contact(
    FirstName = 'John',
    LastName = 'Joseph',
    Email = 'jjhydro@tech.com',
    AccountId=applicantaccId
);


insert applicant;
// The Contacttrigger should trigger

System.debug('CONTACT DETAILS' + applicant);

User[] createdUsers2 = [SELECT Id, Name FROM User WHERE ContactId = :applicant.Id];
System.debug('CREATED USER' + createdUsers2);


//============================================================================================

/* 
// Test changing the password and logging into SF
// It won't let you login and the only way is to have a separate transaction. 
// After changing the password for the first time, changes are instantaneous
// Run top portion first. then once created, comment out the top and only uncomment+run this portion
// to change the password.
// Email temporarily commented out due to email limits.
String ouremail = 'emily.chn@outlook.com';  // applicant.Email
User[] createdUsers2 = [SELECT Id, Name FROM User WHERE Email = :ouremail];
Id contactbid = createdUsers2[0].Id;
System.debug('USER DETAILS WE CREATED' + createdUsers2);


System.setPassword(contactbid, 'welcome1234');

*/