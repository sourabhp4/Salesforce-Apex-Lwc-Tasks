public with sharing class LeadTriggerHandler {
    public LeadTriggerHandler() {

    }

    public static void createAccountContacts (Lead[] leadList) {

        List<Account> accList = new List<Account> ();
        

        for (Lead leadInstance: leadList) {
            accList.add(new Account(
                Name = leadInstance.Company,
                Industry = leadInstance.Industry,
                BillingStreet = leadInstance.Street,
                BillingCity = leadInstance.City,
                BillingPostalCode = leadInstance.PostalCode,
                BillingState = leadInstance.State,
                BillingCountry = leadInstance.Country
            ));
        }

        Database.SaveResult[] saveResults = Database.insert(accList);

        List<Contact> contactList = new List<Contact> ();
        for (Integer i = 0; i < saveResults.size(); i++) {
            contactList.add(new Contact(
                Salutation = leadList[i].Salutation,
                Firstname = leadList[i].Firstname,
                LastName = leadList[i].LastName,
                AccountId = saveResults[i].getId()
            ));
        }

        Database.insert(contactList);
    }
}