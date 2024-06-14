import { LightningElement, api, wire } from 'lwc';
import getRelatedOpportunity from '@salesforce/apex/applicationCheckerController.getRelatedOpportunity';


export default class RelatedOpportunities extends LightningElement {
    @api recordId;
    opportunityId;
    opportunity;
    error;
    warnings;

    columns = [
        { label: 'Name', fieldName: 'Name' , type: 'text'},
        { label: 'Description', fieldName: 'Description' , type: 'text'},
        { label: 'Type', fieldName: 'Type' , type: 'text'}
    ];

    fields = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Stage', fieldName: 'StageName' },
        { label: 'Close Date', fieldName: 'CloseDate' },
        { label: 'Type of Work Category', fieldName: 'Type_of_Work_Catego' },
        { label: 'Region Location', fieldName: 'Region_Location__c' },
        { label: 'Likelihood of Acceptance', fieldName: 'Likelihood_of_Acceptance__c' },
        { label: 'Industry Name', fieldName: 'Industry_Name__c' },
        { label: 'Grant Given', fieldName: 'Grant_Given__r.Name' },
        { label: 'Amount Asked', fieldName: 'Amount_Asked__c' },
        { label: 'Amount', fieldName: 'Amount' },

        { label: 'Contract Start Date', fieldName: 'Contract_Start_Date__c' },
        { label: 'Contract End Date', fieldName: 'Contract_End_Date__c' },
        { label: 'Remaining Days Contract Expires', fieldName: 'Remaining_Days_Contract_Expires__c' }
    ];


    @wire(getRelatedOpportunity, { accountId: '$recordId' })
    wiredOpportunity({ error, data }) {
        //this.rowData = [];
        if (data) {

            this.opportunity  = data;
            this.opportunityId = this.opportunity[0].Id;

            // Check if any warnings
            if (this.opportunity[0].Compliance_Status__c != null ){

                this.warnings = [
                    { Label: 'Status', message: this.opportunity[0].Compliance_Status__c},
                    { Label: 'Progress Note', message: this.opportunity[0].Progress_Note__c},
                    { Label: 'Termination Date', message: this.opportunity[0].Termination_Date__c},
                    { Label: 'Reasonfor Termination', message: this.opportunity[0].Reason_for_Termination__c}
                ];

            }
            else {
                this.warnings = null;
            }

            this.error = null;

        } else if (error) {
            this.error = error.body.message;
            this.relatedOpp = null;
        }
    }

    get opportunityFields() {
        return this.fields.map(field => ({
            label: field.label,
            value: this.opportunity[0][field.fieldName]
        }));
    }

    
}