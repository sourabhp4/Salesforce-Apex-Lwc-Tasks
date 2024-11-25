public with sharing class ContactTriggerHandler {
    public ContactTriggerHandler() {

    }

    public static Boolean isTriggerExecutingBefore = false;
    public static Boolean isTriggerExecutingAfter = false;

    
    // public static void maintainOnePrimaryContact (Contact[] contactsList) {
    //     if (isTriggerExecutingBefore) {
    //         return;
    //     }
    //     isTriggerExecutingBefore = true;

    //     Map<Id, List<Integer>> accountContactIndexMap = new Map<Id, List<Integer>> ();

    //     for (Integer i = 0; i < contactsList.size(); i++) {
    //         if(contactsList[i].Primary_Contact__c == true && contactsList[i].AccountId != NULL){
    //             if(accountContactIndexMap.containsKey(contactsList[i].AccountId)) {
    //                 contactsList[accountContactIndexMap.get(contactsList[i].AccountId)[accountContactIndexMap.get(contactsList[i].AccountId).size() - 1]].Primary_Contact__c = false;
    //                 accountContactIndexMap.get(contactsList[i].AccountId).add(i);
    //             }else {
    //                 accountContactIndexMap.put(contactsList[i].AccountId, new List<Integer>{i});
    //             }
    //         }
    //     }

    //     List<Account> accList = [Select Id, (Select Id From Contacts WHERE Primary_Contact__c = true) From Account Where Id IN :accountContactIndexMap.keySet() ];
    //     List<Contact> contactListToUpdate = new List<Contact> ();

    //     for(Account accInstance: accList) {
    //         accInstance.Primary_Contact_Name__c = contactsList[accountContactIndexMap.get(accInstance.Id)[accountContactIndexMap.get(accInstance.Id).size() - 1]].Firstname + ' ' + contactsList[accountContactIndexMap.get(accInstance.Id)[accountContactIndexMap.get(accInstance.Id).size() - 1]].LastName;
    //         for (Contact contactInstance: accInstance.contacts) {
    //             contactListToUpdate.add(new Contact(Id = contactInstance.Id, Primary_Contact__c = false));
    //         }
    //     }

    //     // for(Account accInstance: accList) {
    //     //     accInstance.Primary_Contact_Name__c = contactsList[accountContactIndexMap.get(accInstance.Id)[accountContactIndexMap.get(accInstance.Id).size() - 1]].Firstname + ' ' + contactsList[accountContactIndexMap.get(accInstance.Id)[accountContactIndexMap.get(accInstance.Id).size() - 1]].LastName;
    //     //     contactListToUpdate.add(accInstance.Contacts);
    //     // }

    //     // for (Contact contactInstance: contactListToUpdate) {
    //     //     contactInstance.Primary_Contact__c = false;
    //     // }

    //     Database.update(accList);
    //     Database.update(contactListToUpdate);
    // }

    // public static void maintainOnePrimaryContactUpdate (Contact[] contactsList, Contact[] contactsListOld) {
    //     if (isTriggerExecutingBefore) {
    //         return;
    //     }
    //     isTriggerExecutingBefore = true;

    //     Map<Id, List<Integer>> accountContactIndexMap = new Map<Id, List<Integer>> ();

    //     for (Integer i = 0; i < contactsList.size(); i++) {
    //         if(contactsList[i].Primary_Contact__c == true && contactsList[i].AccountId != NULL && contactsList[i].Primary_Contact__c != contactsListOld[i].Primary_Contact__c){
    //             if(accountContactIndexMap.containsKey(contactsList[i].AccountId)) {
    //                 contactsList[accountContactIndexMap.get(contactsList[i].AccountId)[accountContactIndexMap.get(contactsList[i].AccountId).size() - 1]].Primary_Contact__c = false;
    //                 accountContactIndexMap.get(contactsList[i].AccountId).add(i);
    //             }else {
    //                 accountContactIndexMap.put(contactsList[i].AccountId, new List<Integer>{i});
    //             }
    //         }
    //     }

    //     List<Account> accList = [Select Id, (Select Id From Contacts WHERE Primary_Contact__c = true) From Account Where Id IN :accountContactIndexMap.keySet() ];
    //     List<Contact> contactListToUpdate = new List<Contact> ();

    //     for(Account accInstance: accList) {
    //         accInstance.Primary_Contact_Name__c = contactsList[accountContactIndexMap.get(accInstance.Id)[accountContactIndexMap.get(accInstance.Id).size() - 1]].Firstname + ' ' + contactsList[accountContactIndexMap.get(accInstance.Id)[accountContactIndexMap.get(accInstance.Id).size() - 1]].LastName;
    //         for (Contact contactInstance: accInstance.contacts) {
    //             contactListToUpdate.add(new Contact(Id = contactInstance.Id, Primary_Contact__c = false));
    //         }
    //     }

    //     // for(Account accInstance: accList) {
    //     //     accInstance.Primary_Contact_Name__c = contactsList[accountContactIndexMap.get(accInstance.Id)[accountContactIndexMap.get(accInstance.Id).size() - 1]].Firstname + ' ' + contactsList[accountContactIndexMap.get(accInstance.Id)[accountContactIndexMap.get(accInstance.Id).size() - 1]].LastName;
    //     //     contactListToUpdate.add(accInstance.Contacts);
    //     // }

    //     // for (Contact contactInstance: contactListToUpdate) {
    //     //     contactInstance.Primary_Contact__c = false;
    //     // }

    //     Database.update(accList);
    //     Database.update(contactListToUpdate);
    // }

    // public static void clearPrimaryContactName (Contact[] contactList) {
    //     Set<Id> accIds = new Set<Id> ();

    //     for (Contact contactInstance: contactList) {
    //         if(contactInstance.Primary_Contact__c == true)
    //             accIds.add(contactInstance.AccountId);
    //     }

    //     List<Account> accList = [Select Id From Account Where Id IN :accIds];

    //     for(Account accInstance: accList) {
    //         accInstance.Primary_Contact_Name__c = NULL;
    //     }

    //     Database.update(accList);
    // }

    // public static void updateActiveContactCount (Contact[] contactList) {

    //     if (isTriggerExecutingAfter) {
    //         return;
    //     }
    //     isTriggerExecutingAfter = true;

    //     Account[] accList = [Select Id, (Select Id From Contacts Where Active__c = True) From Account];

    //     for(Account accInstance: accList) {
    //         accInstance.Active_Contact_Count__c = accInstance.Contacts.size();
    //     }

    //     Database.update(accList);
    // }

    // public static void checkTypeVehicleNumber (Contact[] contactList) {
    //     for (Contact contactInstance: contactList) {
    //         if (contactInstance.Selected_Type__c != NULL && contactInstance.Vehicle_Number__c == NULL) {
    //             contactInstance.addError('Vehicle Number field is required.');
    //         }
    //     }
    // }

    // public static void restrictChangeOfSelectedType (Map<Id, Contact> contactOldMap, Map<Id, Contact> contactNewMap) {
    //     for (Id contactId: contactOldMap.keySet()) {
    //         if (contactOldMap.get(contactId).Selected_Type__c != NULL && contactNewMap.get(contactId).Selected_Type__c != contactOldMap.get(contactId).Selected_Type__c) 
    //             contactNewMap.get(contactId).addError('Selected Type can not be changed');
    //     }
    // }

    // public static void copyContactToClientOrDriver (Contact[] contactList) {

    //     List<Client__c> clientsToCreate = new List<Client__c>();
    //     List<Driver__c> driversToCreate = new List<Driver__c>();
    //     for(Contact contactInstance: contactList) {
    //         if (contactInstance.Selected_Type__c == 'Client') {

    //             clientsToCreate.add(new Client__c(
    //                 Contact__c=contactInstance.Id,
    //                 Name=contactInstance.Firstname + ' ' + contactInstance.LastName,
    //                 Phone_Number__c=contactInstance.Phone,
    //                 Pickup_location__c=contactInstance.mailingStreet + ' ' + contactInstance.mailingCity + ' ' + contactInstance.mailingPostalCode + ' ' + contactInstance.mailingState + ' ' + contactInstance.mailingState + ' ' + contactInstance.mailingCountry,
    //                 Vehicle_number__c=contactInstance.Vehicle_Number__c
    //             ));

    //         }else if (contactInstance.Selected_Type__c == 'Driver') {
    //             driversToCreate.add(new Driver__c(
    //                 Contact__c=contactInstance.Id,
    //                 Name=contactInstance.Firstname + ' ' + contactInstance.LastName,
    //                 Phone_Number__c=contactInstance.Phone,
    //                 Pickup_location__c=contactInstance.mailingStreet + ' ' + contactInstance.mailingCity + ' ' + contactInstance.mailingPostalCode + ' ' + contactInstance.mailingState + ' ' + contactInstance.mailingState + ' ' + contactInstance.mailingCountry,
    //                 Vehicle_number__c=contactInstance.Vehicle_Number__c
    //             ));
    //         }
    //     }
    //     Database.insert(clientsToCreate);
    //     Database.insert(driversToCreate);
    // }


    public static void updateTotalValueAccountAfterInsert (Contact[] contactListNew, Map<Id, Contact> contactMapNew) {

        
        List<Contact> contactListReq = new List<Contact> ();
        Set<Id> accIds = new Set<Id> ();
        for (Contact contactInstance: contactListNew) {
            if (contactInstance.Value__c != null){
                accIds.add(contactInstance.AccountId);
                contactListReq.add(contactInstance);
            }
        }

        List<Account> accountsForUpdate = [Select Id, Total_Value__c From Account Where Id IN :accIds];
        Map<Id, Account> accountsForUpdateMap = new Map<Id, Account> ();

        for (Account accInstance: accountsForUpdate) {
            accountsForUpdateMap.put(accInstance.Id, accInstance);
        }

        for (Contact contactInstance: contactListReq) {
            accountsForUpdateMap.get(contactInstance.AccountId).Total_Value__c = (accountsForUpdateMap.get(contactInstance.AccountId).Total_Value__c == NULL ? 0 : accountsForUpdateMap.get(contactInstance.AccountId).Total_Value__c) + contactInstance.Value__c == NULL ? 0 : contactInstance.Value__c;
        }

        Database.update(accountsForUpdate);
    }
    public static void updateTotalValueAccountAfterUpdate (Contact[] contactListNew, Map<Id, Contact> contactMapOld) {
        // Set<Id> accIds = new Set<Id> ();
        // for (Contact contactInstance: contactListNew) {
        //     if (contactInstance.Value__c != null && contactInstance.Value__c != contactMapOld.get(contactInstance.Id).Value__c)
        //         accIds.add(contactInstance.AccountId);
        // }

        // List<Account> accountsForUpdate = [Select Id, Total_Value__c, (Select Id, Value__c, AccountId From Contacts WHERE Value__c != NULL) From Account Where Id IN :accIds];
        // Map<Id, Account> accountsForUpdateMap = new Map<Id, Account> ();
        // List<Contact> contactsByAccount = new List<Contact> ();
        
        // for (Account accInstance: accountsForUpdate) {
        //     accountsForUpdateMap.put(accInstance.Id, accInstance);
        //     contactsByAccount.addAll(accInstance.Contacts);
        //     accInstance.Total_Value__c = 0;
        // }

        // for (Contact contactInstance: contactsByAccount) {
        //     accountsForUpdateMap.get(contactInstance.AccountId).Total_Value__c += contactInstance.Value__c;
        // }

        // Database.update(accountsForUpdate);

        Set<Id> accIds = new Set<Id> ();
        for (Contact contactInstance: contactListNew) {
            if (contactInstance.Value__c != null && contactInstance.Value__c != contactMapOld.get(contactInstance.Id).Value__c)
                accIds.add(contactInstance.AccountId);
        }

        List<AggregateResult> aggResultList = [Select AccountId, Sum(Value__c) valueSum From Contact WHERE AccountId != NULL Group By AccountId];
        List<Account> accList = new List<Account> ();
        for (AggregateResult agg: aggResultList) {
            accList.add(new Account (
                Id = (Id) agg.get('AccountId'),
                Total_Value__c = (Decimal) agg.get('valueSum')
            ));
        }

        Database.update(accList);
        
        
        ContactTriggerHandler.myFutureMethod();
    }
    
    @future
    public static void myFutureMethod () {   
        User user1 = [SELECT Id, Name, Email FROM User WHERE Username = 'sourabhp9a4z@gmail.com'];
		user1.username = 'sourabhp9a4z@gmail.com';
        Database.update(user1);
    }
    
    public static void updateTotalValueAccountAfterDelete (Contact[] contactListOld, Map<Id, Contact> contactMapOld) {
        Set<Id> accIds = new Set<Id> ();
        for (Contact contactInstance: contactListOld) {
            if (contactInstance.Value__c != null)
                accIds.add(contactInstance.AccountId);
        }

        List<Account> accountsForUpdate = [Select Id, Total_Value__c, (Select Id, Value__c, AccountId From Contacts WHERE Value__c != NULL) From Account Where Id IN :accIds];
        Map<Id, Account> accountsForUpdateMap = new Map<Id, Account> ();
        List<Contact> contactsByAccount = new List<Contact> ();
        
        for (Account accInstance: accountsForUpdate) {
            accountsForUpdateMap.put(accInstance.Id, accInstance);
            contactsByAccount.addAll(accInstance.Contacts);
            accInstance.Total_Value__c = 0;
        }

        for (Contact contactInstance: contactsByAccount) {
            accountsForUpdateMap.get(contactInstance.AccountId).Total_Value__c += contactInstance.Value__c;
        }

        Database.update(accountsForUpdate);

        // List<Contact> contactListReq = new List<Contact> ();
        // Set<Id> accIds = new Set<Id> ();
        // for (Contact contactInstance: contactListOld) {
        //     if (contactInstance.Value__c != null){
        //         accIds.add(contactInstance.AccountId);
        //         contactListReq.add(contactInstance);
        //     }
        // }

        // List<Account> accountsForUpdate = [Select Id, Total_Value__c From Account Where Id IN :accIds];
        // Map<Id, Account> accountsForUpdateMap = new Map<Id, Account> ();
        
        // for (Account accInstance: accountsForUpdate) {
        //     accountsForUpdateMap.put(accInstance.Id, accInstance);
        // }

        // for (Contact contactInstance: contactListReq) {
        //     accountsForUpdateMap.get(contactInstance.AccountId).Total_Value__c = (accountsForUpdateMap.get(contactInstance.AccountId).Total_Value__c == NULL ? 0 : accountsForUpdateMap.get(contactInstance.AccountId).Total_Value__c) - contactInstance.Value__c == NULL ? 0 : contactInstance.Value__c;
        // }

        // Database.update(accountsForUpdate);
    }

}