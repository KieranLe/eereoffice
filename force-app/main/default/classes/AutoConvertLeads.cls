public class AutoConvertLeads {
    @InvocableMethod
    public static void LeadAssign( List<ID> leadIDs ){
        LeadStatus curLeadStatus = [
            SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1
        ];
        
        List<Database.LeadConvert> leadsToConvert = new List<Database.LeadConvert>();
        
        for( ID leadID : leadIDs ) {
            Database.LeadConvert leadConverter = new Database.LeadConvert();
            leadConverter.setLeadId( leadID );
            leadConverter.setConvertedStatus( curLeadStatus.MasterLabel );
            leadsToConvert.add( leadConverter );
        }
        
        if( !leadsToConvert.isEmpty() ){
            List<Database.LeadConvertResult> lcr = Database.convertLead(leadsToConvert);
        }
        
    }

}