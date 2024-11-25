public with sharing class LineItemTriggerHandler {
    public LineItemTriggerHandler() {

    }

    public static void countLineItemsInsert (Line_Item__c[] lineItemList) {

        Set<Id> merchandiseIds = new Set<Id> ();

        for (Line_Item__c lineItemInstance: lineItemList)
            merchandiseIds.add(lineItemInstance.Merchandise__c);

        List<Merchandise__c> merchandiseList = [Select Id, No_of_Line_Items__c, (Select Id from Line_Items_Merchandise__r Where Id IN :lineItemList) From Merchandise__c Where Id IN :merchandiseIds];
        for(Merchandise__c merchandiseInstance: merchandiseList) {
            merchandiseInstance.No_of_Line_Items__c = (merchandiseInstance.No_of_Line_Items__c != NULL ? merchandiseInstance.No_of_Line_Items__c : 0) + merchandiseInstance.Line_Items_Merchandise__r.size();
        }

        Database.update(merchandiseList);
    }

    public static void countLineItemsDelete (Line_Item__c[] lineItemList) {

        Set<Id> merchandiseIds = new Set<Id> ();

        for (Line_Item__c lineItemInstance: lineItemList)
            merchandiseIds.add(lineItemInstance.Merchandise__c);

        List<Merchandise__c> merchandiseList = [Select Id, No_of_Line_Items__c, (Select Id from Line_Items_Merchandise__r Where Id IN :lineItemList) From Merchandise__c Where Id IN :merchandiseIds];
        for(Merchandise__c merchandiseInstance: merchandiseList) {
            merchandiseInstance.No_of_Line_Items__c = (merchandiseInstance.No_of_Line_Items__c != NULL ? merchandiseInstance.No_of_Line_Items__c : 0) - merchandiseInstance.Line_Items_Merchandise__r.size();
        }

        system.debug(merchandiseList);

        Database.update(merchandiseList);
    }
}