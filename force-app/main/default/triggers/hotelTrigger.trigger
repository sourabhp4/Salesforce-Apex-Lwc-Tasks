trigger hotelTrigger on Hotel__c (before insert, after insert, before update) {
    if (trigger.isBefore && (trigger.isInsert || trigger.IsUpdate))  {
        HotelTriggerHandler.requireMaximumCapacity(trigger.new);
    }

    if (trigger.isBefore && trigger.isInsert) {
        HotelTriggerHandler.createHotelReservationsBeforeCheck(trigger.new);
    }

    if (trigger.isAfter && trigger.isInsert) {
        HotelTriggerHandler.createHotelReservations(trigger.new);
    }
}