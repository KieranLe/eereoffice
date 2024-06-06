import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class WebToLeadForm extends LightningElement {

    // Called once form is submitted
    handleSubmit(event){
        console.log('Application Submitted');
        event.preventDefault();
        const fields = event.detail.fields;
        this.template.querySelector('lightning-record-edit-form').submit(fields);
    }

    handleSuccess(event){
        console.log('Handled success');
        const evt = new ShowToastEvent({
                title: 'Small Business Plan Application',
                message: 'Information saved',
                variant: 'success'
        });
        this.dispatchEvent(evt);
    }

}