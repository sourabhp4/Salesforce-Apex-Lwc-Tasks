@isTest
public with sharing class AccountTest {
    public AccountTest() {

    }

    @isTest
    public static void validateAccount() {
        
        Account acc = new Account(Name='Hello Wolrd1', Industry='Electronics');
        insert acc;

        Account accInstance = [Select Id, Rating From Account Where Id=:acc.Id];

        System.assertEquals('Cold', accInstance.Rating);
    }
}