public with sharing class ResetPasswordController {
    public ResetPasswordController() {
    }

    @AuraEnabled
    public static String resetPassword(String userName, String newPassword){
        try{
            // System.setPassword(userId, newPassword);
            User[] currUser = [SELECT Id FROM User WHERE Username = :userName LIMIT 1];
            System.setPassword(currUser[0].Id, newPassword);
            currUser[0].First_Time__c = 0.0;
            currUser[0].Temp_Password__c = 'none';

            update currUser;

            return 'Success';

        } catch( Exception e ) {
            return 'Failure' + e.getMessage();
        }
    }


}