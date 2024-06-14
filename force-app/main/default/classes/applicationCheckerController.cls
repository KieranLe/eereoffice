public with sharing class applicationCheckerController {

    @AuraEnabled(cacheable=true)
    public static User getAccountId() {
        User currUserAccount = [SELECT Contact.AccountId, Contact.Account.Name FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1];
        return currUserAccount;
        //return [SELECT Id, Name FROM Account WHERE Id = :currUserAccount.AccountId LIMIT 1];
    }


    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getRelatedOpportunity(Id accountId) {
        try {
            return [SELECT Id, Name, Description, Type, StageName, 	Type_of_Work_Category__c, Region_Location__c, 
                            Likelihood_of_Acceptance__c, Industry_Name__c, Grant_Given__r.Name, Amount_Asked__c, Amount,
                            Contract_Start_Date__c, Contract_End_Date__c, Remaining_Days_Contract_Expires__c, 
                            Compliance_Status__c, Progress_Note__c, Termination_Date__c, Reason_for_Termination__c
                    FROM Opportunity 
                    WHERE AccountId = :accountId];
        } catch (Exception e) {
            throw new AuraHandledException('Failed to fetch related materials: ' + e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getStage(Id accountId) {
        try {
            return [SELECT StageName
                    FROM Opportunity 
                    WHERE AccountId = :accountId];
        } catch (Exception e) {
            throw new AuraHandledException('Failed to fetch related materials: ' + e.getMessage());
        }
    }
       

    @AuraEnabled(cacheable=true)
    public static List<Case> getRelatedCases(Id accountId) {
        try {
            return [SELECT Id, CaseNumber, Subject, Description, Status
                    FROM Case 
                    WHERE AccountId = :accountId];
        } catch (Exception e) {
            throw new AuraHandledException('Failed to fetch related materials: ' + e.getMessage());
        }
    }


    @AuraEnabled(cacheable=true)
    public static List<Task> getTasks(Id opportunityId) {
        Set<String> filter = new Set<String>();
        filter.add('%Call%');
        filter.add('%Send%');
        //filter.add('%Email%');
        filter.add('%Other%');

        return [SELECT Id, Subject, ActivityDate, Description 
                FROM Task 
                WHERE WhatId = :opportunityId  /// AND Subject LIKE :filter
                ORDER BY ActivityDate DESC];
    }

    @AuraEnabled(cacheable=true)
    public static List<Event> getEvents(Id opportunityId) {
        return [SELECT Id, Subject, ActivityDate, Description 
                FROM Event 
                WHERE WhatId = :opportunityId 
                ORDER BY ActivityDate DESC];
    }

    @AuraEnabled(cacheable=true)
    public static List<EmailMessage> getEmails(Id opportunityId) {
        return [SELECT Id, Subject, CreatedDate, TextBody 
                FROM EmailMessage 
                WHERE RelatedToId = :opportunityId 
                ORDER BY CreatedDate DESC];
    }

    @AuraEnabled(cacheable=true)
    public static List<Task> getCalls(Id opportunityId) {
        return [SELECT Id, Subject, ActivityDate, Description 
                FROM Task 
                WHERE WhatId = :opportunityId AND Subject LIKE '%Call%' 
                ORDER BY ActivityDate DESC];
    }



    @AuraEnabled(cacheable=true)
    public static List<ContentDocumentLinkWrapper> getNotesAndAttachments(Id opportunityId) {
        List<ContentDocumentLinkWrapper> notesAndAttachments = new List<ContentDocumentLinkWrapper>();

        // Fetching attachments (using the ContentDocumentLink object)
        List<ContentDocumentLink> attachments = [SELECT ContentDocument.Title, ContentDocumentId, ContentDocument.CreatedDate, ContentDocument.FileType
                                                FROM ContentDocumentLink
                                                WHERE LinkedEntityId = :opportunityId
        ];
        for (ContentDocumentLink attachment : attachments) {
            notesAndAttachments.add(new ContentDocumentLinkWrapper(
                attachment.ContentDocumentId,
                attachment.ContentDocument.Title,
                attachment.ContentDocument.CreatedDate,
                attachment.ContentDocument.FileType
            ));
        }

        return notesAndAttachments;
    }


    @AuraEnabled
    public static void linkContentDocument(Id opportunityId, Id contentDocumentId) {
        ContentDocumentLink attach = new ContentDocumentLink();
        attach.LinkedEntityId = opportunityId;
        attach.ContentDocumentId = contentDocumentId;
        attach.ShareType = 'V';
        attach.Visibility = 'AllUsers';
        insert attach;
    }

    public class ContentDocumentLinkWrapper {
        @AuraEnabled public Id Id { get; set; }
        @AuraEnabled public String Title { get; set; }
        @AuraEnabled public DateTime CreatedDate { get; set; }
        @AuraEnabled public String Type { get; set; }

        public ContentDocumentLinkWrapper(Id id, String title, DateTime createdDate, String contentType) {
            this.Id = id;
            this.Title = title;
            this.CreatedDate = createdDate;
            this.Type = contentType;
        }
    }
    
    

}