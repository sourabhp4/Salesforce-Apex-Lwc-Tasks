public with sharing class OpportunityLWCController {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunities (String oppName) {
        return [SELECT Id, Name, Amount, StageName, Type FROM Opportunity LIMIT 10 ];
    }

    //Imperative won't require cacheable=true
    @AuraEnabled()
    public static ContactLeadWrapper getContactsLeads (String email) {
        
        ContactLeadWrapper contactLeadWrapperInstance = new ContactLeadWrapper ();

        contactLeadWrapperInstance.contacts = [SELECT Id, FirstName, Phone, Email FROM Contact WHERE Email =: email ];
        contactLeadWrapperInstance.leads = [SELECT Id, FirstName, Phone, Email FROM Lead WHERE Email =: email ];
        
        return contactLeadWrapperInstance;
    }

    //Wrapper class
    public class ContactLeadWrapper {
        @AuraEnabled public List<Contact> contacts;
        @AuraEnabled public List<Lead> leads;
    }

    @AuraEnabled()
    public static List<Contact> getContactsRelated (String accId) {
        Id accountId = (Id) accId;
        return [Select Id, Name FROM Contact WHERE AccountId = :accountId];
    }
}