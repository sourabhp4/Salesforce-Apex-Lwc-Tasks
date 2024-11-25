public with sharing class MerchandiseTriggerHandler {
    public MerchandiseTriggerHandler() {

    }

    public static void doubleUnitPrice (Merchandise__c[] merchandiseList, Map<Id, Merchandise__c> merchandiseMapOld) {

        Set<Id> merchandiseForUpdate = new Set<Id> ();
        for (Merchandise__c merchandiseInstance: merchandiseList) {
            if(merchandiseInstance.Quantity__c == 20 && merchandiseMapOld.get(merchandiseInstance.Id).Quantity__c != 20) {
                merchandiseForUpdate.add(merchandiseInstance.Id);
            }
        }

        if (merchandiseForUpdate.isEmpty())
            return;

        List<Line_Item__c> lineItems = [Select Id, Unit_Price__c FROM Line_Item__c WHERE Merchandise__c IN :merchandiseForUpdate];
    
        for (Line_Item__c lineItemInstance: lineItems) {
            lineItemInstance.Unit_Price__c *= 2;
        }

        Database.update(lineItems);
    }
}