// String contactEmail = 'britney@smith.com';

// Contact[] exampleContact = [ SELECT Id, FirstName, LastName, First_Time_Login__c FROM Contact WHERE Email = :contactEmail LIMIT 1];

// System.debug(exampleContact);

// String username = 'britneysmith@skillstormblue.com';
// User[] currUser = [ SELECT Id, Firstname, Lastname, First_Time__c FROM User WHERE Username= :username];
// System.debug(currUser);
// currUser[0].First_Time__c = 1;
// update currUser;
// System.debug(currUser);

// String contactEmail = 'britney@smith.com';
// Contact[] findContact = [ SELECT Id FROM Contact WHERE Email= :contactEmail LIMIT 1];
// System.debug(findContact);

// String findId = '005Rt000007MxK8IAK';
// User[] currUserId = [ SELECT Firstname, Lastname, First_Time__c FROM User WHERE Id= :findId];
// System.debug(currUserId);

String userName = 'sleepnow@skillstorm.com';
User[] currUserId = [ SELECT Firstname, Lastname, First_Time__c, Temp_Password__c FROM User WHERE Username= :userName];
System.debug(currUserId);