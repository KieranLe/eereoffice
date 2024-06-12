import { LightningElement} from 'lwc';

export default class ResetPasswordPage extends LightningElement {

    username = '';
    newPassword = '';
    confirmPassword = '';

    handleUsername(event){
        this.username = event.target.value;
    }

    handleNewPassword(event){
        this.newPassword = event.target.value;
    }

    handleConfirmPassword(event){
        this.confirmPassword = event.target.value;
    }

    handleClick( event ){
        console.log(this.username);
        console.log(this.newPassword);
        console.log(this.confirmPassword);

        // Scarch org
        window.location.href = "https://energy-power-8280-dev-ed.scratch.my.site.com/loginpage/"

        // Production org
        // window.location.href = "https://theofficeofenergyefficiency-dev-ed.develop.my.site.com/loginpage/"
    }
}