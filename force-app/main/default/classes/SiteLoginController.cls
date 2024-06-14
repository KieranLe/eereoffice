public with sharing class SiteLoginController {

    public SiteLoginController() {
    }

    @AuraEnabled
    public static string loginCheck(String username, String password){
        PageReference pageRef = Site.login(username, password, null);

        if( pageRef != null ){
            User[] currUser = [SELECT Id, First_Time__c FROM User WHERE Username = :username LIMIT 1];

            if( currUser[0].First_Time__c == 1 ){
                return 'FirstLogin';
            } else {
                return 'Success';
            }             
        } else {
            return 'Failure';
        }
}
}


