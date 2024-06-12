import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class WebToCaseForm extends LightningElement {
    
    @api Case;

    // Called once form is submitted
    handleSubmit(event){
        console.log('Inquiry Sent');
        event.preventDefault();
        const fields = event.detail.fields;
        this.template.querySelector('lightning-record-edit-form').submit(fields);
    }

    handleSuccess(event){
        console.log('Handled success');
        const evt = new ShowToastEvent({
                title: 'Inquiry Form',
                message: 'Inquiry Submitted',
                variant: 'success',
        });

        this.dispatchEvent(evt);

    }


}