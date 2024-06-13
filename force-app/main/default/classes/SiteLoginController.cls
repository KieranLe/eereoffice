public with sharing class SiteLoginController {

    public SiteLoginController() {
    }

    @AuraEnabled
    public static string loginCheck(String username, String password){
            PageReference pageRef = Site.login(username, password, null);

            if( pageRef != null ){
                return 'Success';
            } else {
                return 'Failure';
            }
    }
}