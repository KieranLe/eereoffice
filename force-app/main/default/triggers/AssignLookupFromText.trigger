trigger AssignLookupFromText on Lead (before insert) 
{
    for(Lead lead : (List<Lead>) Trigger.new)
    {
        if(Trigger.isInsert && lead.NAICS_Code_Text__c != null)
        {
            
            Map<String, Id> textToLeadIdMap = new Map<String, Id>();
            List<Industry_Fund__c> relatedRecords = [
                SELECT Id
                FROM Industry_Fund__c
                WHERE Name = :lead.NAICS_Code_Text__c
              ];
              
            if (relatedRecords.size() >= 1)
            {
                textToLeadIdMap.put(lead.NAICS_Code_Text__c, relatedRecords[0].Id);

                // Perform Validation here
                lead.Industry_NAICS_Code__c = textToLeadIdMap.get(lead.NAICS_Code_Text__c);
                lead.NAICS_Code_Text__c = null;
            }
        }
    }
}