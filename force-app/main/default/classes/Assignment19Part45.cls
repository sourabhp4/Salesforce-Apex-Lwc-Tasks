public with sharing class Assignment19Part45 {

    public String welcomeMessage;
    public Integer num1;
    public Integer num2;
    public Integer num3;

    public Assignment19Part45() {
        welcomeMessage = 'Welcome to Salesforce';
        num1 = 10;
        num2 = 20;
        num3 = 30;
        System.Debug(welcomeMessage);
        System.Debug(num1 + ' ' + num2 + ' ' + num3);
    }

    public Assignment19Part45(Integer n1, Integer n2, Integer n3) {
        welcomeMessage = 'Welcome to Salesforce';
        num1 = n1;
        num2 = n2;
        num3 = n3;
        System.Debug(welcomeMessage);
        System.Debug(num1 + ' ' + num2 + ' ' + num3);
    }

    public static String sumInches (Integer var1, Integer var2) {
        return Math.floor((var1 + var2) / 12).intValue() + ' feet ' + (Math.mod(var1 + var2, 12)) + ' inches';
    }

    public static String sumMeters (Integer var1, Integer var2) {
        return Math.floor((var1 + var2) / 1000).intValue() + ' km ' + (Math.mod(var1 + var2, 1000)) + ' meters';
    }

    public static Boolean checkString (String input) {
        switch on input {
            when '' {
                return NULL;
            }
            when 'Test' {
                return true;
            }
            when 'Salesforce' {
                return true;
            }
            when else {
                return false;
            }
        }
    }

    public static String rockpaperScissorGame(String p1Move, String p2Move) {
        if (p1Move == p2Move)
            return 'TIE';
        if ( (p1Move == 'Rock' && p2Move == 'Scissor') || (p1Move == 'Paper' && p2Move == 'Rock') || (p1Move == 'Scissor' && p2Move == 'Rock'))
            return 'Player1 wins';
        else
            return 'Player2 wins';
    }

    public static String perform3Actions(String s) {
        return (s.toUpperCase()) + ', ' + (s.contains('value') ? 'Invalid String' : 'Valid String') + ', ' + s + ' Works for ABSYZ';
    }

    public static void reverseArray() {
        List<Integer> numArray = new List<Integer> {1, 2, 3, 4, 5, 6, 7, 8, 9, -10};
        for (Integer i = numArray.size() - 1; i >= 0; i--) 
            System.Debug(numArray[i]);
    }

    public static void displayDate() {
        System.Debug(DateTime.now());
        System.Debug(DateTime.now().addDays(5));
        System.Debug(DateTime.now().addMonths(5));
    }

    public static void buildCars (Integer wheelsCount, Integer bodyCount, Integer peopleCount) {
        System.Debug(Math.min(bodyCount, Math.min(Math.floor(wheelsCount / 4), Math.floor(peopleCount / 2))).intValue());
    }

    public static List<Integer> greaterThanNeighbor() {
        List<Integer> numList = new List<Integer> {10, 20, 5, 2, 100, 99};
        List<Integer> resultList = new List<Integer> ();

        if (numList.size() < 3)
            return NULL;
        for (Integer i = 1; i < numList.size() - 1; i++) {
            if (numList[i] > numList[i - 1] && numList[i] > numList[i + 1])
                resultList.add(numList[i]);
        }

        return resultList;
    }

    public static void countMatchingCharacters () {
        String s1 = 'Apple';
        String s2 = 'Algae';
        Integer count = 0;

        List<String> s1List = new List<String> (s1.split(''));

        for (String char1: s1List) {
            if (s2.contains(char1))
                count++;
        }
        System.Debug(count);
    }

    public static void createBox(Integer n) {
        for (Integer i = 0; i < n; i++) {
            if(i == 0 || i == n - 1) 
                System.Debug('#'.repeat(n));
            else
                System.Debug('#' + ' '.repeat(n - 2) + '#');
        }
    }

    public static void createInvoices(String invoiceName) {
        List<Invoice__c> newInvoices = new List<Invoice__c> ();

        for (Integer i = 0; i < 10; i++) {
            newInvoices.add(new Invoice__c(Name__c = invoiceName, Status__c = 'Open'));
        }

        Database.insert(newInvoices);
    }

    public static void updateInvoices(String invoiceName) {
        Invoice__c[] invoicesToUpdate = [Select Id, Value__c From Invoice__c WHERE Name__c = :invoiceName+' ABSYZ'];
        System.Debug(invoicesToUpdate);

        for (Invoice__c invoiceInstance: invoicesToUpdate) {
            invoiceInstance.Value__c = 100;
        }

        Database.update(invoicesToUpdate);
    }

    public static Map<Id, List<Line_Item__c>> getMerchandiseLineItemRecords () {
        Map<Id, List<Line_Item__c>> merchandiseWithLineItem = new Map<Id, List<Line_Item__c>>();

        List<Merchandise__c> merchandiseList = [Select Id, Name, (Select Id, Name From Line_Items_Merchandise__r) From Merchandise__c];

        for (Merchandise__c merchandiseInstance: merchandiseList) {
            merchandiseWithLineItem.put(merchandiseInstance.Id, merchandiseInstance.Line_Items_Merchandise__r);
        }

        return merchandiseWithLineItem;
    }

    public static void updateStatus() {
        List<Invoice__c> invoiceList = [Select Id, (Select Id, Line_Item_Total__c From Line_Items__r) From Invoice__c];

        List<Invoice__c> invoicesForUpdate = new List<Invoice__c> ();
        for (Invoice__c invoiceInstance: invoiceList) {
            Decimal sum = 0;
            for (Line_Item__c lineItemInstance: invoiceInstance.Line_Items__r) {
                sum += lineItemInstance.Line_Item_Total__c;
            }
            if (sum > 100)
                invoicesForUpdate.add(new Invoice__c(Id=invoiceInstance.Id, status__c = 'Closed' ));
        }

        Database.update(invoicesForUpdate);
    }

    public static void updateLineItemBasedOnMerchandise () {
        List<Merchandise__c> merchandiseList = [Select Id, (Select Id From Line_Items_Merchandise__r) From Merchandise__c WHERE Price__c = 100 AND No_of_Line_Items__c = 5];

        List<Line_Item__c> lineItemsForUpdate = new List<Line_Item__c> ();

        for (Merchandise__c merchandiseInstance: merchandiseList) {
            for (Line_Item__c lineItemInstance: merchandiseInstance.Line_Items_Merchandise__r) {
                lineItemsForUpdate.add(new Line_Item__c(Id=lineItemInstance.Id, Unit_Price__c=20));
            }
        }

        Database.update(lineItemsForUpdate);
    }

    public static void updateInvoiceRecords () {
        List<Merchandise__c> merchandiseList = [Select Id From Merchandise__c Where Order_Complete__c = true];

        if(merchandiseList.size() > 0) {
            List<Invoice__c> invoiceList = [Select Id From Invoice__c];
            for (Invoice__c invoiceInstance: invoiceList) {
                invoiceInstance.Order_Complete__c = true;
            }
            Database.update(invoiceList);
        }
    }
}