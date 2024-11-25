@RestResource(urlMapping='/Cases/*')
global class ApexRestClass {
	@HttpGet
    global static List<Case> getMethod() {
        RestRequest req = RestContext.request;
        String subject = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
        String key = '%'+ subject + '%';
        return [SELECT Id, Subject, Origin, Description FROM Case WHERE Subject LIKE :key];
        //return [SELECT Id, Subject, Origin, Description FROM Case];
    }
    
    @HttpDelete
    global static void deleteMethod() {
        RestRequest req = RestContext.request;
        String subject = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
        String key = '%'+ subject + '%';
        List<Case> casesForDelete = [SELECT Id, Subject, Origin, Description FROM Case WHERE Subject LIKE :key];
        Database.delete(casesForDelete);
    }
    
    @HttpPost
    global static void postMethod (String origin, String subject, String description) {
        Database.insert(new Case(
            Origin = origin,
            Subject = subject,
            Description = description
        ));
    }
}