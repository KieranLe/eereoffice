import { LightningElement, api, wire} from 'lwc';
import getNotesAndAttachments from '@salesforce/apex/applicationCheckerController.getNotesAndAttachments';
import linkContentDocument from '@salesforce/apex/applicationCheckerController.linkContentDocument';
import { refreshApex } from '@salesforce/apex';

export default class OpportunityNotesAttachments extends LightningElement {
    @api opportunityId;
    notesAttachments = [];

    columns = [
        { label: 'Title', fieldName: 'Title', type: 'text' },
        { label: 'Created Date', fieldName: 'CreatedDate', type: 'date' },
        { label: 'Type', fieldName: 'Type', type: 'text' }
    ];


    @wire(getNotesAndAttachments, { opportunityId: '$opportunityId' })
    wiredNotesAttachments({ error, data }) {
        if (data) {
            this.notesAttachments = data;

        } else if (error) {
            console.error('Error fetching notes and attachments', error);
        }
    }

    handleUploadFinished(event) {
        console.log("HEYYYY");
        // Get the list of uploaded files
        const uploadedFiles = event.detail.files;
        alert('No. of files uploaded : ' + uploadedFiles.length);
        
    }
}