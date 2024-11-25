trigger hotelReservationTrigger on Hotel_Reservation__c (after insert, after update, after delete) {

    if (trigger.isAfter && (trigger.isInsert || trigger.isUpdate)) {
        HotelReservationTriggerHandler.calculateCurrentCapacity(trigger.new);
    }

    if (trigger.isAfter && (trigger.isDelete)) {
        HotelReservationTriggerHandler.calculateCurrentCapacity(trigger.old);
    }
}