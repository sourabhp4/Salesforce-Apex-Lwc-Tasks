public with sharing class Assignment29 {
    
    @AuraEnabled (cacheable=true)
    public static List<Contact> getRelatedContacts (String accId) {
        return [SELECT Id, Name, Title, Phone, Email, Owner.Name FROM Contact WHERE AccountId=:accId];
    }

    @AuraEnabled
    public static List<Account> getAllAccounts(){
        try {
            return [SELECT Id, Name From Account];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled (cacheable=true)
    public static List<Contact> getAllContacts () {
        return [SELECT Id, Name, Title, Phone, Email, Owner.Name FROM Contact LIMIT 5];
    }

    @AuraEnabled (cacheable=true)
    public static List<Contact> getAllContactsSearch (String conName) {
        if (conName == '')
            return new List<Contact> ();
        String key = '%' + conName + '%';
        return [SELECT Id, Name, Title, Phone, Email FROM Contact WHERE Name LIKE :key LIMIT 5];
    }

    @AuraEnabled (cacheable=true)
    public static List<Contact> getTenContacts () {
        return [SELECT Id, Name FROM Contact LIMIT 10];
    }

    @AuraEnabled (cacheable=true)
    public static List<Account> getRelatedAccounts () {
        return [SELECT Id, Name FROM Account LIMIT 10];
    }
}