import { LightningElement, wire } from 'lwc';
import getAccountDetails from '@salesforce/apex/AccountUserSettingsController.getAccountDetails';
import getContactDetails from '@salesforce/apex/AccountUserSettingsController.getContactDetails';

import USER_ID from '@salesforce/user/Id';

export default class AccountUserSettings extends LightningElement {

    userId = USER_ID;
    userName = 'a_young@dickenson.com';
    account;
    contact;
    showSuccessMessage = false;

    @wire(getAccountDetails, {userName: '$userName'} )
    wiredAccount({ error, data }) {
        if (data) {
            this.account = data;
        } else if (error) {
            console.error('Error retrieving account details: ', error);
        }
    }

    @wire(getContactDetails, {userName: '$userName'} )
    wiredContact({ error, data }) {
        if (data) {
            this.contact = data;
        } else if (error) {
            console.error('Error retrieving contact details: ', error);
        }
    }

    handleSuccess(event) {
        this.showSuccessMessage = true;
        // Automatically hide the success message after 5 seconds
        setTimeout(() => {
            this.showSuccessMessage = false;
        }, 5000);
    }

}