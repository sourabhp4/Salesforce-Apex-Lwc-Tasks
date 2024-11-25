trigger LeadTrigger on Lead (after insert) {

    if (trigger.isAfter && trigger.isInsert) {
        LeadTriggerHandler.createAccountContacts(trigger.new);
    }
}