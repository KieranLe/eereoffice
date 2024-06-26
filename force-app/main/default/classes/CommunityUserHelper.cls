public class CommunityUserHelper {


    // Creates community user and sets temporary password, sends email
    public static void createCommunityUser(Contact newContact) {
        // Ensure the contact has an email and is not already associated with a User
        if (newContact.Email != null && newContact.Email != '' && [SELECT COUNT() FROM User WHERE ContactId = :newContact.Id] == 0) {
           
            // Query the Customer Community profile
            Profile communityProfile = [SELECT Id FROM Profile WHERE Name = 'Customer Community Login User' LIMIT 1];

            // Create the new User (needs Contact and Account)
            User newUser = new User(
                FirstName = newContact.FirstName,
                LastName = newContact.LastName,
                Email = newContact.Email,
                Username = newContact.FirstName + newContact.LastName + '@skillstormBlue.com', // Ensure Username is unique across all Salesforce orgs
                Alias = (newContact.FirstName.substring(0,1) ) + (newContact.LastName.substring(0,4)),
                CommunityNickname = (newContact.FirstName.substring(0,1) ) + (newContact.LastName.substring(0,4)),

                //new
                // Temp_Password__c = 'abc123456',
                Temp_Password__c = generateTemporaryPassword(),
                First_Time__c = 1,

                ProfileId = communityProfile.Id,
                ContactId = newContact.Id,
                
                TimeZoneSidKey = 'America/Los_Angeles', // Set appropriate time zone
                LocaleSidKey = 'en_US', // Set appropriate locale
                EmailEncodingKey = 'UTF-8', // Set appropriate email encoding
                LanguageLocaleKey = 'en_US' // Set appropriate language
            );

            // Insert the new User
            try {
                insert newUser;


                // Create username and password, and pass into future method for email
                String newUserId = newUser.Id;
                String tempPass = newUser.Temp_Password__c;

                // String password = generateTemporaryPassword();    // uncomment this in prod
                // String password = 'welcome123';                     // remove this in prod

                // Set temporary password and send email
                // sendTemporaryPasswordEmail(newUserId, password);
                sendTemporaryPasswordEmail(newUserId, tempPass);

            } catch (Exception e) {
                System.debug('Error creating user: ' + e.getMessage());
            }
        } 
    }


    // Sends the email for a temporary password once user is created and password set
    public static void sendTemporaryPasswordEmail(String newUserId, String password) {
        try {
            System.setPassword(newUserId, password);

            User newUser = [SELECT Id, FirstName, Username, Email FROM User WHERE Id= :newUserId LIMIT 1];
            
            // Create an email template
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[] { newUser.Email });
            email.setSubject('Your Temporary Password');
            email.setPlainTextBody('Dear ' + newUser.FirstName 
                    + ',\n\nYour Username is: '+ newUser.Username 
                    + '\nYour temporary password is: ' + password 
                    + '\n\nPlease log in and change your password as soon as possible. Your account may take several minutes to become fully functional. ' 
                    + '\n\nBest regards,\nThe Office of Energy Efficiency and Renewable Energy');

            // Send the email
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
            System.debug('Email sent to: ' + newUser.Email);
            

        } catch (Exception e) {
            System.debug('Error in sendTemporaryPasswordEmail: ' + e.getMessage());
        }
    }

    // Generates random temporary password
    public static String generateTemporaryPassword()
    {
        // Generate a temporary password
        // Example: 8b3c82fd39
        Integer len = 10;
        Blob blobKey = crypto.generateAesKey(128);
        String key = EncodingUtil.convertToHex(blobKey);
        String temppassword = key.substring(0,len);
        return temppassword;
    }

}

