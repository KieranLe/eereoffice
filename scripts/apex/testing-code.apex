// String contactEmail = 'britney@smith.com';

// Contact[] exampleContact = [ SELECT Id, FirstName, LastName, First_Time_Login__c FROM Contact WHERE Email = :contactEmail LIMIT 1];

// System.debug(exampleContact);

String username = 'britneysmith@skillstormblue.com';
User[] currUser = [ SELECT Id, Firstname, Lastname FROM User WHERE Username= :username];
System.debug(currUser);