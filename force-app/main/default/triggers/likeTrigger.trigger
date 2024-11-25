trigger likeTrigger on Like__c (before insert, after insert) {
    // if(trigger.isBefore && trigger.isInsert) {
        
    //     Map<Id, Integer> postIdWithlikeCountmap = new Map<Id, Integer> ();
    //     for(Like__c likeInstance: trigger.new) {
    //         if(postIdWithlikeCountmap.containsKey(likeInstance.Post__c)) {
    //             postIdWithlikeCountmap.put(likeInstance.Post__c, postIdWithlikeCountmap.get(likeInstance.Post__c) + 1);
    //             continue;
    //         }
    //         postIdWithlikeCountmap.put(likeInstance.Post__c, 1);
    //     }

    //     List<Post__c> postsToUpdateList = [Select Id, Likes__c, (Select Id From Likes__r) FROM POST__C WHERE Id IN :postIdWithlikeCountmap.keySet()];
    //     for (Post__c postInstance: postsToUpdateList) {
    //         postInstance.Likes__c = postInstance.Likes__r.size() + postIdWithlikeCountmap.get(postInstance.Id);
    //     }

    //     Database.update(postsToUpdateList);
    // }

    if (trigger.isAfter && trigger.isInsert) {

        Set<Id> postIdSet = new Set<Id>();
        for (Like__c likeInstance: trigger.new) {
            if(likeInstance.Id != NULL)
                postIdSet.add(likeInstance.Post__c);
        }

        List<Post__c> postsToUpdateList = [Select Id, Likes__c, (Select Id From Likes__r WHERE Id IN: trigger.new) FROM POST__C WHERE Id IN :postIdSet];
        for (Post__c postInstance: postsToUpdateList) {
            postInstance.Likes__c = postInstance.Likes__r.size();
        }

        Database.update(postsToUpdateList);
    }


}