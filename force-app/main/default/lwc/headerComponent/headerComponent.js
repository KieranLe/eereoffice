import { LightningElement } from 'lwc';


export default class HeaderComponent extends LightningElement {
     
    activeTab = 'tab1';

    
    // These are for testing with the scratch org
    //logoURL     = 'https://energy-power-8280-dev-ed.scratch.my.site.com/resource/1717637222000/EERE_Logo';          
    //homepageIMG = 'https://energy-power-8280-dev-ed.scratch.my.site.com/resource/1717637243000/Homepage';           


    // These are for the production org
    logoURL     = 'https://theofficeofenergyefficiency-dev-ed.develop.my.site.com/resource/1717637222000/EERE_Logo';          
    homepageIMG = 'https://theofficeofenergyefficiency-dev-ed.develop.my.site.com/resource/1717637243000/Homepage';    
    

    get itemOneClass() {
        return this.activeTab === 'tab1' ? 'slds-tabs_default__item slds-is-active' : 'slds-tabs_default__item';
    }

    get itemTwoClass() {
        return this.activeTab === 'tab2' ? 'slds-tabs_default__item slds-is-active' : 'slds-tabs_default__item';
    }

    get itemThreeClass() {
        return this.activeTab === 'tab3' ? 'slds-tabs_default__item slds-is-active' : 'slds-tabs_default__item';
    }

    get itemFourClass() {
        return this.activeTab === 'tab4' ? 'slds-tabs_default__item slds-is-active' : 'slds-tabs_default__item';
    }

    get isItemOneSelected() {
        return this.activeTab === 'tab1';
    }

    get isItemTwoSelected() {
        return this.activeTab === 'tab2';
    }

    get isItemThreeSelected() {
        return this.activeTab === 'tab3';
    }

    get isItemFourSelected() {
        return this.activeTab === 'tab4';
    }

    get tabOneContentClass() {
        return this.activeTab === 'tab1' ? 'slds-tabs_default__content slds-show slds-p-around_small' : 'slds-tabs_default__content slds-hide slds-p-around_small';
    }

    get tabTwoContentClass() {
        return this.activeTab === 'tab2' ? 'slds-tabs_default__content slds-show slds-p-around_small' : 'slds-tabs_default__content slds-hide slds-p-around_small';
    }

    get tabThreeContentClass() {
        return this.activeTab === 'tab3' ? 'slds-tabs_default__content slds-show slds-p-around_small' : 'slds-tabs_default__content slds-hide slds-p-around_small';
    }

    get tabFourContentClass() {
        return this.activeTab === 'tab4' ? 'slds-tabs_default__content slds-show slds-p-around_small' : 'slds-tabs_default__content slds-hide slds-p-around_small';
    }

    handleTabClick(event) {
        event.preventDefault();
        this.activeTab = event.target.dataset.tab;
    }

    handleLoginClick(event){
        event.preventDefault();
        // Scatch org
        //window.location.href = 'https://energy-power-8280-dev-ed.scratch.my.site.com/loginpage/';

        // Production
        window.location.href = 'https://theofficeofenergyefficiency-dev-ed.develop.my.site.com/loginpage/';
    }

}
