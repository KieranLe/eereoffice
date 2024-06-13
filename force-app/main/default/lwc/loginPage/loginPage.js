import { LightningElement } from 'lwc';
import loginCheck from '@salesforce/apex/SiteLoginController.loginCheck';

export default class LoginPage extends LightningElement {

    username;
    password;
    errorMessage;

    // This is for scratch org
    logoURL = 'https://energy-power-8280-dev-ed.scratch.my.site.com/resource/1717551614000/EERE_Logo';
    
    // This is for the production org
    // logoURL = 'https://theofficeofenergyefficiency-dev-ed.develop.my.site.com/resource/1717637222000/EERE_Logo'

    handleUsername( event ){
        this.username = event.target.value;
    }

    handlePassword( event ){
        this.password = event.target.value;
    }


    async handleLogin( event ){
        event.preventDefault();

        try{
            const result =  await loginCheck( {username: this.username, password: this.password} );

            if( result === 'Success'){
                this.errorMessage = '';
                // Scratch org
                //window.location.href = "https://energy-power-8280-dev-ed.scratch.my.site.com/customerportal/";
                
                // Production org
                window.location.href ='https://energy-power-8280-dev-ed.scratch.my.site.com/customerportal'
            } else {
                this.errorMessage='Login Failed. Please check your Username and Password.';
            }
        } catch (error) {
            this.errorMessage = 'An error occurred during login. Please try again.';
        }
    }


    handleForgetPassword( event ){
        event.preventDefault();
        console.log("Forget Password is clicked");
        
        // Scratch Org
        window.location.href = "https://energy-power-8280-dev-ed.scratch.my.site.com/forgetpassword/";

        // Production Org
        // window.location.href = "https://theofficeofenergyefficiency-dev-ed.develop.my.site.com/resetpassword/";
    }


}