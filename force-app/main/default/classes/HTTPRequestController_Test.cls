@isTest
public with sharing class HTTPRequestController_Test {
    // Mock class for the HTTP callout
    private class MockHttpResponse implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setStatusCode(200);
            res.setBody('[{"title": "Energy Coal","description": "Description of Energy Coal","modified": "2021-01-01","accessLevel": "public","identifier": "1","landingPage": "http://example.com","license": "open","rights": "none","spatial": "global","temporal": "2021","accrualPeriodicity": "daily","keyword": ["coal", "energy"],"bureauCode": ["123"],"programCode": ["456"],"theme": ["Energy"]}]');
            return res;
        }
    }

    @isTest
    static void testParseArticles() {
        // Set up the mock HTTP response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse());
        
        // Define filters
        List<String> titleFilters = new List<String>{'Energy'};
        List<String> keywordFilters = new List<String>{'coal'};
        List<String> themeFilters = new List<String>{'Energy'};
        List<String> bureauCodeFilters = new List<String>{'123'};
        List<String> programCodeFilters = new List<String>{'456'};

        Test.startTest();
        String filteredArticles = HTTPRequestController.parseArticles(titleFilters, keywordFilters, themeFilters, bureauCodeFilters, programCodeFilters);
        Test.stopTest();

        // Deserialize the response to check the results
        List<HTTPRequestController.ProjectItem> filteredItems = (List<HTTPRequestController.ProjectItem>) JSON.deserialize(filteredArticles, List<HTTPRequestController.ProjectItem>.class);

        // Assert the results
        Assert.areEqual(1, filteredItems.size());
        //Assert.areEqual('Energy Coal', filteredItems[0].title);
    }

    @isTest
    static void testParseArticlesNoFilters() {
        // Set up the mock HTTP response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse());

        // Define empty filters
        List<String> titleFilters = new List<String>();
        List<String> keywordFilters = new List<String>();
        List<String> themeFilters = new List<String>();
        List<String> bureauCodeFilters = new List<String>();
        List<String> programCodeFilters = new List<String>();

        Test.startTest();
        String filteredArticles = HTTPRequestController.parseArticles(titleFilters, keywordFilters, themeFilters, bureauCodeFilters, programCodeFilters);
        Test.stopTest();

        // Deserialize the response to check the results
        List<HTTPRequestController.ProjectItem> filteredItems = (List<HTTPRequestController.ProjectItem>) JSON.deserialize(filteredArticles, List<HTTPRequestController.ProjectItem>.class);

        // Assert the results
        Assert.areEqual(1, filteredItems.size());
        //Assert.areEqual('Energy Coal', filteredItems[0].title);
    }

    @isTest
    static void testParseArticlesNoMatches() {
        // Set up the mock HTTP response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse());

        // Define filters that do not match any articles
        List<String> titleFilters = new List<String>{'Nonexistent'};
        List<String> keywordFilters = new List<String>{'Nonexistent'};
        List<String> themeFilters = new List<String>{'Nonexistent'};
        List<String> bureauCodeFilters = new List<String>{'000'};
        List<String> programCodeFilters = new List<String>{'000'};

        Test.startTest();
        String filteredArticles = HTTPRequestController.parseArticles(titleFilters, keywordFilters, themeFilters, bureauCodeFilters, programCodeFilters);
        Test.stopTest();

        // Deserialize the response to check the results
        List<HTTPRequestController.ProjectItem> filteredItems = (List<HTTPRequestController.ProjectItem>) JSON.deserialize(filteredArticles, List<HTTPRequestController.ProjectItem>.class);

        // Assert the results
        Assert.areEqual(0, filteredItems.size());
    }
}