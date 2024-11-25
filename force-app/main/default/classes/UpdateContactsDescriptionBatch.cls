public with sharing class UpdateContactsDescriptionBatch implements Database.Batchable<SObject>, Database.Stateful {
    public UpdateContactsDescriptionBatch() {
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Description, Account.Name, Account.Description FROM Contact WHERE AccountId != NULL');
    }

    public void execute(Database.BatchableContext bc, List<SObject> scope) {

        Account accInstance;
        for (SObject record : scope) {
            Contact contactInstance = (Contact) record;
            accInstance = contactInstance.Account;
            contactInstance.Description = accInstance.Name + ': ' + (accInstance.Description == NULL ? '' : accInstance.Description);
        }
        Database.update(scope);
    }

    public void finish(Database.BatchableContext bc) {
    }
}