@isTest
public with sharing class ContactTriggerTest {
    public ContactTriggerTest() {

    }

    @TestSetup
    static void makeData(){
        Account newAcc = new Account(
            Name='NewAccount'
        );

        Database.insert(newAcc);

        Contact newContact1 = new Contact(
            LastName='NewContact1',
            AccountId=newAcc.Id,
            Value__c=1000
        );

        Database.insert(newContact1);
    }

    @isTest
    public static void totalValueUpdateOnContactInsert () {

        Account acc = [Select Id, Total_Value__c From Account WHERE Name='NewAccount' LIMIT 1];

        Contact newContact1 = new Contact(
            LastName='NewContact2',
            AccountId=acc.Id,
            Value__c=1000
        );

        Database.insert(newContact1);

        Account acc1 = [Select Id, Total_Value__c From Account WHERE Name='NewAccount' LIMIT 1];

        System.assertEquals(2000.0, acc1.Total_Value__c);

    }

    @isTest
    public static void totalValueUpdateOnContactUpdate () {

        Contact oldContact = [Select Id From Contact Where LastName='NewContact1' LIMIT 1];

        oldContact.Value__c = 2000;

        Database.update(oldContact);

        Account acc = [Select Id, Total_Value__c From Account WHERE Name='NewAccount' LIMIT 1];

        System.assertEquals(2000.0, acc.Total_Value__c);
    }

    @isTest
    public static void totalValueUpdateOnContactDelete () {

        Contact oldContact = [Select Id From Contact Where LastName='NewContact1' LIMIT 1];

        Database.delete(oldContact);

        Account acc = [Select Id, Total_Value__c From Account WHERE Name='NewAccount' LIMIT 1];

        System.assertEquals(0.0, acc.Total_Value__c);
    }

}