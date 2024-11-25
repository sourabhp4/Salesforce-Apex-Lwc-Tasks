public with sharing class AssignmentClass {
    public AssignmentClass() {  
    }

    public Integer smallNum (List<Integer> numList) {
        if(numList.isEmpty()){
            return 0;
        }
        numList.sort();
        return numList[0];
    }   
    public Integer searchKeyInList (List<Integer> keyList, Integer keyToFind) {        
        return keyList.indexOf(keyToFind);
    }
    
    public Integer searchStringsList (List<String> stringList) {

        return stringlist.size();

        // Integer stringCount = 0;

        // for (String strIntance : stringList) {
        //     if(strInstance == stringToFind)
        //     stringCount++;
        // }

        // return stringCount;

    }

    public void addAccounts () {
        List<Account> accountsList = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            Account acc = new Account();
            acc.Name = 'Test Account';
            accountsList.add(acc);
        }

        insert accountsList;
    }

    public void updateAccounts () {
        Account[] accountsToUpdate = [SELECT Name from Account WHERE Name='Test Account' AND Industry != 'Education' AND Type != 'Installation Partner'];

        for (Account acc: accountsToUpdate) {
            acc.Industry = 'Education';
            acc.Type = 'Installation Partner';
        }

        update accountsToUpdate;
    }

    public void displayAccount () {
        Map<Account, List<Contact>> accMap = new Map<Account, List<Contact>> ();
        List<Account> accList = [Select Id, Name, (Select Id, Name FROM Contacts) FROM Account];
        
        for(Account acc: accList) {
            accMap.put(acc, acc.contacts);
        }

        System.Debug(accMap);
    }

    public void insertAccountOpportunity () {
        Account newAccount = new Account();
        newAccount.Name = 'New Account';
        insert newAccount;

        Opportunity newOpp = new opportunity();
        newOpp.AccountId = newAccount.Id;
        newOpp.Name = 'Test opp';
        newOpp.CloseDate = Date.parse('12/12/2024');
        newOpp.StageName = 'Prospecting';
        insert newOpp;
    }

    public void displayAccountsContactsOpps () {
        for (Account acc: [Select Id, Name, (Select Id, Name FROM Contacts), (SELECT Id, Name FROM OPPORTUNITIES) FROM Account]){
            System.Debug('Account: ' + acc.Name);
            for (Contact conInstance: acc.Contacts) {
                System.Debug('Contact: ' + conInstance.Name);
            }
            for (Opportunity oppInstance: acc.Opportunities) {
                System.Debug('Opportunity: ' + oppInstance.Name);
            }
        }
    }
 }