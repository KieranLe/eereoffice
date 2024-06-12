import { LightningElement } from 'lwc';

export default class LoginPage extends LightningElement {

    username = '';
    password = '';

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

    handleLogin( event ){
        console.log(this.username);
        console.log(this.password);

        if( this.username == 'admin@eere.com' && this.password == 'admin'){
            // Scratch org
            window.location.href = "https://energy-power-8280-dev-ed.scratch.my.site.com/customerportal/";

            // Production org
            // window.location.href = "https://theofficeofenergyefficiency-dev-ed.develop.my.site.com/customerportal/";
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