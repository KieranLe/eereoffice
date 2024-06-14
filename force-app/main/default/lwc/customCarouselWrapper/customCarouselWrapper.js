import { LightningElement } from 'lwc';
import CAROUSEL_IMAGES from '@salesforce/resourceUrl/carousel'

export default class CustomCarouselWrapper extends LightningElement {

    slides=[
        {
            image:`${CAROUSEL_IMAGES}/carousel-images/solar-banner.jpg`
            
        },
        {
            image:`${CAROUSEL_IMAGES}/carousel-images/wind-technician.jpg`
            
        },        
        {
            image:`${CAROUSEL_IMAGES}/carousel-images/hydro-banner.jpg`
            
        },
        {
            image:`${CAROUSEL_IMAGES}/carousel-images/product-engineers.jpg`
            
        }          
    ];

}