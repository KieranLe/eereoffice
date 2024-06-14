import { LightningElement } from 'lwc';
import loginCheck from '@salesforce/apex/SiteLoginController.loginCheck';
import Id from '@salesforce/user/Id';

export default class LoginPage extends LightningElement {

    username;
    password;
    errorMessage;
    //userId;

    // This is for scratch org
    // logoURL = 'https://energy-power-5603-dev-ed.scratch.my.site.com/resource/1718308323000/EERE_Logo';

    
    // This is for the production org
    logoURL = 'https://theofficeofenergyefficiency-dev-ed.develop.my.site.com/resource/1717637222000/EERE_Logo'

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
            console.log('result of login check: ', result);
            if( result === 'Success'){
                this.errorMessage = '';

                // This is for Scratch org
                // window.location.href = "https://efficiency-ruby-5603-dev-ed.scratch.my.site.com/customerportal";
                
                // Production org
                window.location.href ='https://theofficeofenergyefficiency-dev-ed.develop.my.site.com/customerportal'

            } else if ( result === 'FirstLogin'){
                this.errorMessage = '';

                // Scratch Org
                // window.location.href = 'https://efficiency-ruby-5603-dev-ed.scratch.my.site.com/resetpassword'; 

                // Production org
                window.location.href ='https://theofficeofenergyefficiency-dev-ed.develop.my.site.com/resetpassword';

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
        // window.location.href = "https://efficiency-ruby-5603-dev-ed.scratch.my.site.com/resetpassword";

        // Production Org
        window.location.href = "https://theofficeofenergyefficiency-dev-ed.develop.my.site.com/resetpassword/";
    }


}