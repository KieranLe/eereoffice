import { LightningElement, api } from 'lwc';

export default class Launch_login_page extends LightningElement {

    //@api
    //username;

    handleLogin(event) {
        event.preventDefault();
        // Handle login
        const username = this.template.querySelector('input[name="username"]').value;
        const password = this.template.querySelector('input[name="password"]').value;
        //const username = document.getElementById('username').value;
        
        console.log(`Username: ${username}, Password: ${password}`);

        // Add additional login logic here
        
    }

    handleSignUp() {
        // Handle sign-up logic
        console.log('Sign Up button clicked');
    }

    handleForgotPassword() {
        // Handle forgot password logic
        console.log('Forgot Password button clicked');
    }

    handleWebToLeadForm() {
        // Handle Web-to-Lead form logic
        console.log('Web-to-Lead Form button clicked');
    }

    handleContactUs() {
        // Handle contact us logic
        console.log('Contact Us button clicked');
    }
}