public with sharing class MovieTriggerHandler {
    public MovieTriggerHandler() {

    }

    public static void sendEmailOnAllActorsAvailable (List<Movie__c> newMovieList, Map<Id, Movie__c> oldMovieMap, Boolean isUpdate, Boolean isInsert) {

        Set<Id> movieIds = new Set<Id> ();
        for (Movie__c movieInstance: newMovieList) {
            if (movieInstance.All_actors_are_available__c == true && (isInsert || (isUpdate && movieInstance.All_actors_are_available__c != oldMovieMap.get(movieInstance.Id).All_actors_are_available__c)))
                movieIds.add(movieInstance.Id);
        }

        List<Movie__c> movieList = [Select Id, Name, Director__r.Email From Movie__c Where Id IN :movieIds];

        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage> ();

        for (Movie__c movieInstance: movieList) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setSubject('All Actors are available');
            mail.setToAddresses(new String[] { movieInstance.Director__r.Email });
            mail.setPlainTextBody('All actors are available for the Movie: ' + movieInstance.Name );

            emails.add(mail);
        }

        Messaging.sendEmail(emails);
    }
}