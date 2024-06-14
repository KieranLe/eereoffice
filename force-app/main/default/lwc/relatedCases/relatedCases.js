import { LightningElement, api, wire } from 'lwc';
import getRelatedCases from '@salesforce/apex/applicationCheckerController.getRelatedCases';


export default class RelatedOpportunities extends LightningElement {
    @api 
    recordId;
    relatedCases;
    error;
    //rowData = []
    columns = [
        { label: 'Case Number', fieldName: 'CaseNumber' },
        { label: 'Subject', fieldName: 'Subject'},
        { label: 'Description', fieldName: 'Description' },
        { label: 'Status', fieldName: 'Status' }
    ];

    @wire(getRelatedCases, { accountId: '$recordId' })
    wiredOpportunity({ error, data }) {
        //this.rowData = [];
        if (data) {

            this.relatedCases = data; // <--faster way, May change this
            /*this.rowData = data.map(record => ({
                Id: record.Id,
                Name: record.Name,
                Description: record.Description,
                Type: record.Type
            }));*/

            this.error = null;

        } else if (error) {
            this.error = error.body.message;
            this.relatedCases = null;
        }
    }
}