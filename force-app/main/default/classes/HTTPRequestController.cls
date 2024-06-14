public with sharing class HTTPRequestController {

    static String  jsonResponse = getArticles();
    static List<ProjectItem> allItems = (List<ProjectItem>) JSON.deserialize(jsonResponse, List<ProjectItem>.class);

    public class ProjectItem
    {
        // Class properties don't have to include every property in the JSON, but the property names need to be exact matches
        String title;
        String description; // too lengthy to be meaningful?
        String modified;
        String accessLevel;
        String identifier;
        String landingPage;
        String license;
        String rights;
        String spatial;
        String temporal;
        String accrualPeriodicity;
        // publisher -> @type, name
        // contactPoint -> should be a class with String fn, String hasEmail
        // distribution -> should be a class with dtype, mediaType, title, downloadURL
        List<String> keyword;
        List<String> bureauCode;
        List<String> programCode;
        //List<String> references;
        List<String> theme;
    }


    private static String getArticles() {
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('callout:Appian_EERE_Endpoint_Credentials/suite/webapi/articles');
        Http http = new Http();

        try {
            HttpResponse res = http.send(req);

            if (res.getStatusCode() == 200) {
                return res.getBody();
            } else {
                System.debug('Error response: ' + res.getBody());
            }

        } catch (Exception e) {
            System.debug('Exception: ' + e.getMessage());
        }
        return null;
    }
 

    // Method to parse and filter articles
    @AuraEnabled(cacheable=true)
    public static String parseArticles(List<String> titleFilters, List<String> keywordFilters, List<String> themeFilters, List<String> bureauCodeFilters, List<String> programCodeFilters) {
        
        if (jsonResponse == null) {
            return JSON.serialize(new List<ProjectItem>());
        }
        
        List<ProjectItem> filteredItems = new List<ProjectItem>();

        for (ProjectItem item : allItems) {
            Boolean matches = true;

            if (!matchesFilter(item.title, titleFilters)) {
                matches = false;
            } else if (!matchesFilter(item.keyword, keywordFilters)) {
                matches = false;
            } else if (!matchesFilter(item.theme, themeFilters)) {
                matches = false;
            } else if (!matchesFilter(item.bureauCode, bureauCodeFilters)) {
                matches = false;
            } else if (!matchesFilter(item.programCode, programCodeFilters)) {
                matches = false;
            }

            if (matches) {
                filteredItems.add(item);
            }
        }

        return JSON.serialize(filteredItems);
    }


    // Helper method to check if an item matches any of the filters
    private static Boolean matchesFilter(String itemProperty, List<String> filters) {
        if (filters == null || filters.isEmpty()) {
            return true;
        }
        if (itemProperty == null) {
            return false;
        }

        for (String filter : filters) {
            if (itemProperty.toLowerCase().contains(filter.toLowerCase())) {
                return true;
            }
        }

        return false;
    }

    private static Boolean matchesFilter(List<String> itemProperties, List<String> filters) {
        if (filters == null || filters.isEmpty()) {
            return true;
        }
        if (itemProperties == null || itemProperties.isEmpty()) {
            return false;
        }

        // Any word that matches filter word in the sentence.       Example: 'coal' = 'Engery coal'      MATCHES then gets that article
        for (String filter : filters) {
            String lowerFilter = filter.toLowerCase();
            for (String itemProperty : itemProperties) {
                if ( itemProperty.toLowerCase().contains(lowerFilter) ){
                    return true;
                }
            }
        }
        
        return false;
    }
    
}