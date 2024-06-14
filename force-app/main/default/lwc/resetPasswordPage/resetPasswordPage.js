import { LightningElement, wire} from 'lwc';
import resetPassword from '@salesforce/apex/ResetPasswordController.resetPassword';
import Id from "@salesforce/user/Id"



export default class ResetPasswordPage extends LightningElement {

    username;
    newPassword;
    confirmPassword;
    errorMessage;
    dupErrorMessage;
    userId = Id;

    handleUsername(event){
        this.username = event.target.value;
    }

    handleNewPassword(event){
        this.newPassword = event.target.value;
        this.validatePassword();
    }

    handleConfirmPassword(event){
        this.confirmPassword = event.target.value;
        this.validatePassword();
    }

    validatePassword(){
        if(!this.confirmPassword){
            this.dupErrorMessage = 'Confirmed Password is required';
        } else if ( !(this.newPassword === this.confirmPassword) ) {
            this.dupErrorMessage = 'Passwords do not match';
        } else {
            this.dupErrorMessage = '';
        }
    }
    

    async handleClick( event ){

        try{
            const result = await resetPassword( {userName: this.username, newPassword: this.newPassword });
            console.log('Result result = ', result);
            console.log('username: ', this.username)
            if( result === 'Success' ){
                this.errorMessage = '';
                
                // Scratch org
                // window.location.href = 'https://efficiency-ruby-5603-dev-ed.scratch.my.site.com/loginPage';

                // Production org
                window.location.href ='https://theofficeofenergyefficiency-dev-ed.develop.my.site.com/loginpage';

            } else {
                this.errorMessage = 'Password reset failed. Try again';
            }
        } catch (error)
        {
            this.errorMessage = 'An error occurred. Please try again.';
        }

        // Scarch org
        // window.location.href = "https://efficiency-ruby-5603-dev-ed.scratch.my.site.com/loginPage";

        // Production org
        // window.location.href = "https://theofficeofenergyefficiency-dev-ed.develop.my.site.com/loginpage/"
    }

}