import { LightningElement, api, wire} from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import ACCOUNT_NAME_FIELD  from '@salesforce/schema/Account.Name';
import getAccountId from '@salesforce/apex/applicationCheckerController.getAccountId';

import USER_ID from '@salesforce/user/Id';

export default class usersProgressViewPage extends LightningElement {

    //recordId = '001aj00000Kj59hAAB';
    recordId;
    userId = USER_ID;
    userName = 'a_young@dickenson.com';
    cardTitle = 'Awaiting Record ID';
    isMenuOpen = false;

    username;

    
    @wire(getRecord, { recordId : '$recordId', fields : [ACCOUNT_NAME_FIELD] })
    wiredAccount(result){
        if(result.data){
            this.cardTitle = 'Account: '+ getFieldValue(result.data, ACCOUNT_NAME_FIELD);       
        }
        else if(result.error){
            this.cardTitle = 'Could not retreive account name with record id = ' + this.recordId;
        }
    }
        
    @wire(getAccountId, {userName: '$userName'})
    wiredUser({ error, data }) {
        if (data) {
            this.recordId = data.Contact.AccountId;
            this.cardTitle = 'Account: ' + data.Contact.Account.Name;
        } else if (error) {
            this.cardTitle = 'Could not retreive account name with record id' ;
        }
    }

 
    connectedCallback() {
        const urlParams = new URLSearchParams(window.location.search);
        this.username = urlParams.get('username');
        console.log('Extracted username:', this.username);
    }

}