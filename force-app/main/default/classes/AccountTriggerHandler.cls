public with sharing class AccountTriggerHandler {
    public AccountTriggerHandler() {

    }

    // public static Set<Id> accountIds = new Set<Id> ();

    public static void updateRating (Account[] accList) {

        for (Account accInstance: accList) {
            switch on accInstance.Industry {
                when 'Agriculture' {
                    accInstance.Rating = 'Hot';
                }
                when 'Consulting' {
                    accInstance.Rating = 'Warm';
                }
                when 'Electronics' {
                    accInstance.Rating = 'Cold';
                }
                when else {
                    accInstance.Rating = Null;
                }
            }
        }
    }

    public static void preventDeleteIfMoreThan3Contacts (Account[] accList) {

        Account[] accountsWithContacts = [Select Id, (Select Id From Contacts) From Account Where Id IN :accList];

        for (Account accInstance: accountsWithContacts) {
            if(accInstance.Contacts.size() > 3)
                accList[0].addError('Accounts with more than 3 contacts can not be deleted.');
        }
    }

    public static void updateChildAccountPhone (Account[] accListNew, Map<Id, Account> accMapNew, Map<Id, Account> accMapOld) {
        
        Set<Id> parentIds = new Set<Id> ();

        for (Account accInstance: accListNew) {
            if(accInstance.phone != accMapOld.get(accInstance.Id).phone)
                parentIds.add(accInstance.Id);
        }

        Account[] childrenAccounts = [Select Id, ParentId From Account Where ParentId IN :parentIds];
        // Account[] childrenAccountToUpdate = new List<Account> ();

        for (Account childAccountInstance: childrenAccounts) {
            childAccountInstance.phone = accMapNew.get(childAccountInstance.parentId).phone;
            // childrenAccountToUpdate.add(new Account(Id = childAccountInstance.Id, Phone = accMapNew.get(childAccountInstance.parentId).phone));
        }

        // Database.update(childrenAccountToUpdate);
        Database.update(childrenAccounts);
        
        // List<Account> accListForUpdate = new List<Account> ();



        // for (Account accInstance: accListNew) {

        //     if (accInstance.Phone == accMapOld.get(accInstance.Id).Phone) {
        //         return;
        //     }

        //     // if (accountIds.contains(accInstance.Id) || accInstance.Id == accInstance.ParentId) {
        //     //     return;
        //     // }
        //     // accountIds.add(accInstance.Id);

        //     Account[] currentAccountChildren = [Select Id From Account Where ParentId = :accInstance.Id];

        //     for (Account accCurrentAccountChild: currentAccountChildren) {
        //         accListForUpdate.add(new Account(Id=accCurrentAccountChild.Id, Phone=accInstance.phone));
        //     }
        // }

        // Database.update(accListForUpdate);
    }
}