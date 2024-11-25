public class ApexREST {
	
    @AuraEnabled(Cacheable=true)
    public static List<Object> getAnimalNames () {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'animals' key as a list
            List<Object> animals = (List<Object>) results.get('animals');
            System.debug('Received the following animals:');
            System.Debug(animals);
            for(Object animal: animals) {
                System.debug(animal);
            }
			return animals;            
        }
        return new List<Object> ();
    } 
}