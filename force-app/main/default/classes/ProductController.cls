public with sharing class ProductController {

    @AuraEnabled (Cacheable=True)
    public static List<Product2> getAllProducts(String productCodeString, String sortBy, String sortDirection) {
        try {
            System.Debug(sortBy + ' ' + sortDirection);
            if (productCodeString != null && productCodeString != ''){
                String likeString = productCodeString + '%';
                return Database.query('SELECT Name, ProductCode FROM Product2 WHERE ProductCode LIKE ' + likeString + ' ORDER BY ' + sortBy + ' ' + sortDirection + ' LIMIT 15');
            }
            else {
                return Database.query('SELECT Name, ProductCode FROM Product2 ORDER BY ' + sortBy + ' ' + sortDirection + ' LIMIT 15');
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled (Cacheable=True)
    public static List<Account_Product__c> getExistingProducts (String accountId) {
        try {
            return [SELECT Name, Account__r.Name, Product__r.Name FROM Account_Product__c WHERE Account__c=:accountId LIMIT 15];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class ProductWrapper {
        @AuraEnabled public String productName { get; set; }
        @AuraEnabled public String productId { get; set; }
    }

    @AuraEnabled
    public static boolean createAccountProducts(String accountId, List<ProductWrapper> products){
        try {

            List<Account_Product__c> accountProductsToCreate = new List<Account_Product__c> ();
            for (ProductWrapper productInstance: products) {
                accountProductsToCreate.add(new Account_Product__c(Name=productInstance.productName, Account__c=accountId, Product__c=productInstance.productId));
            }

            Database.insert(accountProductsToCreate);

            return true;
            
        } catch (Exception e) {
            System.Debug(e.getMessage());
        }
        return false;
    }

}