import { LightningElement } from 'lwc';

export default class ErrorPage extends LightningElement {

    headingText = 'An unexpected connection error occurred.';
    bodyText = 'Please try refreshing the page.';

    setErrorMessage(headingText, bodyText)
    {
        this.headingText = headingText;
        this.bodyText = bodyText;
    }
}