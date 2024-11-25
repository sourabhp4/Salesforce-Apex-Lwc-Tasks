public with sharing class HotelTriggerHandler {
    public HotelTriggerHandler() {

    }

    public static void requireMaximumCapacity (Hotel__c[] hotelList) {
        for(Hotel__c hotelInstance: hotelList) {
            if (hotelInstance.Maximum_Capacity__c == NULL) {
                hotelInstance.addError('Maximum Capacity is required.');
            }
        }
    }

    public static void createHotelReservationsBeforeCheck (Hotel__c[] hotelList) {
        List<Hotel_Reservation__c> newHotelreservations = new List<Hotel_Reservation__c> ();

        Map<Id, List<Integer>> accToHotelMap = new Map<Id, List<Integer>> ();
        for (Integer i = 0; i < hotelList.size(); i++) {
            if (hotelList[i].Associated_Account__c != NULL) {
                if (accToHotelMap.containsKey(hotelList[i].Associated_Account__c)){
                    accToHotelMap.get(hotelList[i].Associated_Account__c).add(i);
                }else {
                    accToHotelMap.put(hotelList[i].Associated_Account__c, new List<Integer> {i});
                }
            }
        }

        Account[] accountList = [Select Id, Name, (Select Id, FirstName, LastName From Contacts Where Active__c = True) From Account Where Id IN :accToHotelMap.keySet()];

        for (Account accInstance: accountList) {
            for(Integer hotelIndex: accToHotelMap.get(accInstance.Id)) {
                if (accInstance.Contacts.size() > hotelList[accToHotelMap.get(accInstance.Id)[0]].Maximum_Capacity__c)
                    hotelList[accToHotelMap.get(accInstance.Id)[0]].addError('New hotel_reservations can\'t be completed');
            }
        }
    }
    
    public static void createHotelReservations (Hotel__c[] hotelList) {
        List<Hotel_Reservation__c> newHotelreservations = new List<Hotel_Reservation__c> ();

        Map<Id, List<Integer>> accToHotelMap = new Map<Id, List<Integer>> ();
        for (Integer i = 0; i < hotelList.size(); i++) {
            if (hotelList[i].Associated_Account__c != NULL) {
                if (accToHotelMap.containsKey(hotelList[i].Associated_Account__c)){
                    accToHotelMap.get(hotelList[i].Associated_Account__c).add(i);
                }else {
                    accToHotelMap.put(hotelList[i].Associated_Account__c, new List<Integer> {i});
                }
            }
        }

        Account[] accountList = [Select Id, Name, (Select Id, FirstName, LastName From Contacts Where Active__c = True) From Account Where Id IN :accToHotelMap.keySet()];


        Map<Id, Account> accountMap = new Map<Id, Account> ();

        for (Account accInstance: accountList) {

            accountMap.put(accInstance.Id, accInstance);
        }
        
        for (Hotel__c hotelInstance: hotelList) {

            for (Contact contactInstance: accountMap.get(hotelInstance.Associated_Account__c).Contacts) {
                newHotelreservations.add( new Hotel_Reservation__c(
                    Name=accountMap.get(hotelInstance.Associated_Account__c).name + ' ' + contactInstance.FirstName + ' ' + contactInstance.LastName,
                    Hotel__c=hotelInstance.Id,
                    Associate_Contact__c=contactInstance.Id,
                    status__c='Reserved'
                ));
            }
        }

        Database.insert(newHotelreservations);
    }
}