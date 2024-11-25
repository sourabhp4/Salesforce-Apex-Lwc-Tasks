public with sharing class HotelReservationTriggerHandler {
    public HotelReservationTriggerHandler() {

    }

    public static void calculateCurrentCapacity (Hotel_Reservation__c[] hotelReservationList) {
        Set<Id> hotelIds = new Set<Id>();

        for (Hotel_Reservation__c hotelReservationInstance: hotelReservationList)
            if(hotelReservationInstance.Hotel__c != NULL)
                hotelIds.add(hotelReservationInstance.Hotel__c);

        List<Hotel__c> hotelsForUpdate = [Select Id, Maximum_Capacity__c From Hotel__c Where Id IN :hotelIds];

        List<AggregateResult> hotelToReservationsCount = [Select Hotel__c, Count(Id) hotelCount From Hotel_Reservation__c WHERE Status__c = 'Reserved' AND Hotel__c IN :hotelIds Group By Hotel__c];

        Map<Id, Integer> hotelToReservationsCountMap = new Map<Id, Integer> ();
        for (AggregateResult hotelReservationInstance: hotelToReservationsCount) {
            hotelToReservationsCountMap.put((Id) hotelReservationInstance.get('Hotel__c'), (Integer) hotelReservationInstance.get('hotelCount'));
        }

        for (Hotel__c hotelInstance: hotelsForUpdate) {
            if (hotelToReservationsCountMap.get(hotelInstance.Id) > hotelInstance.Maximum_Capacity__c){
                hotelReservationList[0].addError('Current capacity can not exceed maximum capacity of a hotel');
                return;
            }
            else
                hotelInstance.Current_Seating_capacity__c = hotelToReservationsCountMap.get(hotelInstance.Id);
        }

        Database.update(hotelsForUpdate);
    }
}