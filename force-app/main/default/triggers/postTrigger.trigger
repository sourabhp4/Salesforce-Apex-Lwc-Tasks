trigger postTrigger on Post__c (before insert, before update, after update) {

    // if (trigger.isBefore && trigger.isUpdate) {
        
    //     for (Post__c postInstance: trigger.new) {

    //         if(postInstance.Likes__c > 2 && postInstance.Content__c.length() > 20) {
    //             postInstance.Content__c.addError('Length must be less than 21 characters');
    //         }else if (postInstance.Likes__c <= 2 && postInstance.Content__c.length() > 30){
    //             postInstance.Content__c.addError('Length must be less than 31 characters');
    //         }
    //     }
    // }

    if (trigger.isAfter && trigger.isUpdate) {
        PostTriggerHandler.updateHandler(trigger.new);
    }

    // if (trigger.isBefore && trigger.isUpdate) {

    //     List<Post__c> postsUpdated = new List<Post__c> (trigger.new);
    //     for(Post__c postInstance: postsUpdated) {
    //         if (postInstance.Likes__c == postInstance.Comments__c) {
    //             postInstance.Content__c = 'Likes and comments are equal';
    //         }
    //     }
    // }
}