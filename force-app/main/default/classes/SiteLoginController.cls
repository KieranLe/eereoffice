public with sharing class SiteLoginController {

    public SiteLoginController() {
    }

    @AuraEnabled
    public static string loginCheck(String username, String password){
        
        try {
            User[] currUser = [SELECT Id, First_Time__c, Temp_Password__c  FROM User WHERE Username = :username];

            if( currUser[0].First_Time__c == 1 && currUser[0].Temp_Password__c == password ){
                return 'FirstLogin'; 
            } else {
                PageReference pageRef = Site.login(username, password, null);

                if( pageRef != null ){
                    return 'Success';
                } else {
                    return 'Failure'; 
                }             
            }         
        } catch (Exception e) {
            return 'Failure' + e.getMessage();
        }
    
    }
}


