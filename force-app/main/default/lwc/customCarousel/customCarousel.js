import { LightningElement , api } from 'lwc';


const CARD_VISIBLE_CLASSES = 'slds-show';
const CARD_HIDDEN_CLASSES = 'slds-hide';


export default class CustomCarousel extends LightningElement {

    @api slidesData
    /*
    get slidesData(){

    }
    set slidesData(data){
        data.map((item, index) => {
            return index === 0 ? {
                ...item,
                slideIndex: index+1,
                cardClasses:CARD_VISIBLE_CLASSES
            }:{
                ...item,
                slideIndex: index+1,
                cardClasses:CARD_HIDDEN_CLASSES
            }
            
        })
    }
    */


}