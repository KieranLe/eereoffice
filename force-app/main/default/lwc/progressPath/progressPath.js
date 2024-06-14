import { LightningElement, api, wire} from 'lwc';
import getStage from '@salesforce/apex/applicationCheckerController.getStage';


export default class ProgressPath extends LightningElement {
    @api recordId;
    errorMessage;
    currentStage;


    steps = [
        { label: 'Concept Paper', value: 'Concept Paper' },
        { label: 'Full Application Stage', value: 'Full Application Stage' },
        { label: 'Selection Stage', value: 'Selection Stage' },
        { label: 'Negotiation Stage', value: 'Negotiation Stage' },
        { label: 'Project Performance Stage', value: 'Project Performance Stage' },
        { label: 'Closed', value: 'Closed' },
        { label: 'Project Complete', value: 'Project Complete' }
    ];

    @wire( getStage, {accountId : '$recordId'} )
    wiredStage(result){
        if(result.data){
            
            //this.currentStage = result.data[0];
            /*this.currentStage = result.data.map(record => ({
                stage: record.StageName
            }));*/
            this.currentStage = result.data[0]['StageName'];
            
            //console.log(this.currentStage.StageName);
            //console.log(this.currentStage);

            this.errorMessage = null;
        }
        else if(result.error){
            this.errorMessage = 'Could not retreive stage';
        }
    }



}
