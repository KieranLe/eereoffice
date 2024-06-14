import { LightningElement, api, wire} from 'lwc';
import getTasks from '@salesforce/apex/applicationCheckerController.getTasks';
import getEvents from '@salesforce/apex/applicationCheckerController.getEvents';
import getEmails from '@salesforce/apex/applicationCheckerController.getEmails';
import getCalls from '@salesforce/apex/applicationCheckerController.getCalls';

export default class Activities extends LightningElement {
    @api opportunityId;

    tasks;
    taskError;
    isLoadingTasks = true;

    events;
    eventError;
    isLoadingEvents = true;

    emails;
    emailError;
    isLoadingEmails = true;

    calls;
    callError;
    isLoadingCalls = true;

    @wire(getTasks, { opportunityId: '$opportunityId' })
    wiredTasks({ error, data }) {
        this.isLoadingTasks = false;
        if (data) {
            this.tasks = data;
            this.taskError = null;
        } else if (error) {
            this.taskError = error.body.message;
            this.tasks = null;
        }
    }

    @wire(getEvents, { opportunityId: '$opportunityId' })
    wiredEvents({ error, data }) {
        this.isLoadingEvents = false;
        if (data) {
            this.events = data;
            this.eventError = null;
        } else if (error) {
            this.eventError = error.body.message;
            this.events = null;
        }
    }

    @wire(getEmails, { opportunityId: '$opportunityId' })
    wiredEmails({ error, data }) {
        this.isLoadingEmails = false;
        if (data) {
            this.emails = data;
            this.emailError = null;
        } else if (error) {
            this.emailError = error.body.message;
            this.emails = null;
        }
    }

    @wire(getCalls, { opportunityId: '$opportunityId' })
    wiredCalls({ error, data }) {
        this.isLoadingCalls = false;
        if (data) {
            this.calls = data;
            this.callError = null;
        } else if (error) {
            this.callError = error.body.message;
            this.calls = null;
        }
    }
}