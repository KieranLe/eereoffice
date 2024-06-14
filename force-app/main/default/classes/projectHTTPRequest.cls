public with sharing class projectHTTPRequest {

    public class ProjectItem
    {
        // Class properties don't have to include every property in the JSON, but the property names need to be exact matches
        String title;
        String description; // too lengthy to be meaningful?
        //Date modified
        //String accessLevel 
        // String identifier
        // Boolean dataQuality
        // String describedBy
        String landingPage;
        // String license;
        // publisher -> @type, name
        // contactPoint -> should be a class with String fn, String hasEmail
        // distribution -> should be a class with dtype, mediaType, title, downloadURL
        List<String> keyword;
        List<String> bureauCode;
        List<String> programCode;
        //List<String> references;
        List<String> theme;
    }


    public static void projectsGetRequestwithCredentials(){

        // Create http request object
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');           // GET method to retrieve data from Appian instance
        req.setEndpoint('callout:Appian_EERE_Endpoint_Credentials/suite/webapi/articles');      // referring to the named credentials

        // create Http object to send request
        Http http = new Http();
        HttpResponse resp = http.send(req);       
        
        System.debug(resp.getStatusCode());
        System.debug(resp.getBody());

        // Deserialize the JSON
        List<ProjectItem> items = (List<ProjectItem>)JSON.deserialize(resp.getBody(), List<ProjectItem>.class);  // need to cast from object to actual class
        //System.debug(items);
        for(ProjectItem item : items)   // 100 total items
        {
            System.debug(item);
        }

    }


}