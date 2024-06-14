public with sharing class ResetPasswordController {
    public ResetPasswordController() {
    }

    @AuraEnabled
    public static String resetPassword(String userId, String newPassword){
        try{

            System.setPassword(userId, newPassword);
            User currUser = [SELECT Id FROM User WHERE Id = :userId LIMIT 1];
            currUser.First_Time__c = 0;
            update currUser;
            return 'Success';

        } catch( Exception e ) {
            return 'Failure' + e.getMessage();
        }
    }
}