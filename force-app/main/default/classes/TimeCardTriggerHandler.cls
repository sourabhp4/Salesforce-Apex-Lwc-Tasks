public with sharing class TimeCardTriggerHandler {

    private static List<String> labelApiIds = new List<String> {
        'Jan_Lock_Date', 'Feb_Lock_Date', 'Mar_Lock_Date', 'Apr_Lock_Date', 'May_Lock_Date', 'Jun_Lock_Date',
        'Jul_Lock_Date', 'Aug_Lock_Date', 'Sep_Lock_Date', 'Oct_Lock_Date', 'Nov_Lock_Date', 'Dec_Lock_Date'
    };

    public static void beforeInsert(List<Timecard_Header__c> newList) {
        for (Timecard_Header__c timeCard: newList) {

            if (timeCard.Start_Date__c.toStartOfWeek() + 1 != timeCard.Start_Date__c) {
                timeCard.Start_Date__c.addError('Start Date must be Monday');
                continue;
            }
            if (timeCard.End_Date__c.toStartOfWeek() != timeCard.End_Date__c) {
                timeCard.End_Date__c.addError('End Date must be Sunday');
                continue;
            }
            if (timeCard.Start_Date__c + 6 != timeCard.End_Date__c) {
                timeCard.addError('End Date must be succeding Sunday to Start date');
                continue;
            }

            Integer currentMonth = timeCard.Today_s_Date__c.month();
            String labelApiName = labelApiIds[currentMonth - 1];

            Integer lockDay = Integer.valueOf(System.label.get('', labelApiName));
            Date lockDate = Date.newInstance(timeCard.Today_s_Date__c.year(), timeCard.Today_s_Date__c.month(), lockDay);
            
            if (timeCard.Today_s_Date__c < lockDate){
                Integer newMonth = timeCard.Today_s_Date__c.month();
                Integer newYear = timeCard.Today_s_Date__c.year();
                Integer newDay;
                if (newMonth == 1) {
                    newMonth = 12;
                    newYear -= 1;
                    newDay = Integer.valueOf(System.label.get('', labelApiIds[11]));
                } else {
                    newMonth -= 1;
                    newDay = Integer.valueOf(System.label.get('', labelApiIds[newMonth]));
                }
                
                lockDate = Date.newInstance(newYear, newMonth, newDay);
            }

            if (timeCard.Start_Date__c > lockDate || (timeCard.Start_Date__c.month() == lockDate.month() && timeCard.Start_Date__c.year() == lockDate.year())) {
                continue;
            }

            if (timeCard.Start_Date__c.month() != timeCard.End_Date__c.month() && lockDate.month() == timeCard.End_Date__c.month() && lockDate.year() == timeCard.End_Date__c.year()) {
                Date startDayOfMonth = lockDate.toStartOfMonth();
                Date startDate = timeCard.Start_Date__c;
                if (startDate + 1 == startDayOfMonth && timeCard.Monday_Hours__c != 0) {
                    timeCard.addError('You can not edit monday hours');
                }else if (startDate + 2 == startDayOfMonth && (timeCard.Monday_Hours__c != 0 || timeCard.Tuesday_Hours__c != 0)) {
                    timeCard.addError('You can not edit monday-tuesday hours');
                }else if (startDate + 3 == startDayOfMonth && (timeCard.Monday_Hours__c != 0 || timeCard.Tuesday_Hours__c != 0 || timeCard.Wednesday_Hours__c != 0)) {
                    timeCard.addError('You can not edit monday-wednesday hours');
                }else if (startDate + 4 == startDayOfMonth && (timeCard.Monday_Hours__c != 0 || timeCard.Tuesday_Hours__c != 0 || timeCard.Wednesday_Hours__c != 0 || timeCard.Thursday_Hours__c != 0)) {
                    timeCard.addError('You can not edit monday-thursday hours');
                }else if (startDate + 5 == startDayOfMonth && (timeCard.Monday_Hours__c != 0 || timeCard.Tuesday_Hours__c != 0 || timeCard.Wednesday_Hours__c != 0 || timeCard.Thursday_Hours__c != 0 || timeCard.Friday_Hours__c != 0)) {
                    timeCard.addError('You can not edit monday-friday hours');
                }else if (startDate + 6 == startDayOfMonth && (timeCard.Monday_Hours__c != 0 || timeCard.Tuesday_Hours__c != 0 || timeCard.Wednesday_Hours__c != 0 || timeCard.Thursday_Hours__c != 0 || timeCard.Friday_Hours__c != 0  || timeCard.Saturday_Hours__c != 0)) {
                    timeCard.addError('You can not edit monday-saturday hours');
                }
            }

            else {
                timeCard.addError('This record can not be inserted');
            }
        }
    }

    public static void beforeUpdate (Map<Id, Timecard_Header__c> newMap, Map<Id, Timecard_Header__c> oldMap) {
        for (Id timeCardId: newMap.keyset()) {

            
            if (newMap.get(timeCardId).Start_Date__c.toStartOfWeek() + 1 != newMap.get(timeCardId).Start_Date__c ) {
                newMap.get(timeCardId).Start_Date__c.addError('Start Date must be Monday');
                continue;
            }
            if (newMap.get(timeCardId).End_Date__c.toStartOfWeek() != newMap.get(timeCardId).End_Date__c ) {
                newMap.get(timeCardId).End_Date__c.addError('End Date must be Sunday');
                continue;
            }
            if (newMap.get(timeCardId).Start_Date__c + 6 != newMap.get(timeCardId).End_Date__c ) {
                newMap.get(timeCardId).addError('End Date must be succeding Sunday to Start date');
                continue;
            }

            Integer currentMonth = newMap.get(timeCardId).Today_s_Date__c.month();
            String labelApiName = labelApiIds[currentMonth - 1];

            Integer lockDay = Integer.valueOf(System.label.get('', labelApiName));
            Date lockDate = Date.newInstance(newMap.get(timeCardId).Today_s_Date__c.year(), newMap.get(timeCardId).Today_s_Date__c.month(), lockDay);
            
            if (newMap.get(timeCardId).Today_s_Date__c < lockDate){
                Integer newMonth = newMap.get(timeCardId).Today_s_Date__c.month();
                Integer newYear = newMap.get(timeCardId).Today_s_Date__c.year();
                Integer newDay;
                if (newMonth == 1) {
                    newMonth = 12;
                    newYear -= 1;
                    newDay = Integer.valueOf(System.label.get('', labelApiIds[11]));
                } else {
                    newMonth -= 1;
                    newDay = Integer.valueOf(System.label.get('', labelApiIds[newMonth]));
                }
                
                lockDate = Date.newInstance(newYear, newMonth, newDay);
            }

            if (newMap.get(timeCardId).Start_Date__c > lockDate || (newMap.get(timeCardId).Start_Date__c.month() == lockDate.month() && newMap.get(timeCardId).Start_Date__c.year() == lockDate.year())) {
                continue;
            }

            if (newMap.get(timeCardId).Start_Date__c.month() != newMap.get(timeCardId).End_Date__c.month() && lockDate.month() == newMap.get(timeCardId).End_Date__c.month() && lockDate.year() == newMap.get(timeCardId).End_Date__c.year()) {
                Date startDayOfMonth = lockDate.toStartOfMonth();
                Date startDate = newmap.get(timeCardId).Start_Date__c;
                if (startDate + 1 == startDayOfMonth && newMap.get(timeCardId).Monday_Hours__c != oldMap.get(timeCardId).Monday_Hours__c) {
                    newMap.get(timeCardId).addError('You can not edit monday hours');
                }else if (startDate + 2 == startDayOfMonth && (newMap.get(timeCardId).Monday_Hours__c != oldMap.get(timeCardId).Monday_Hours__c || newMap.get(timeCardId).Tuesday_Hours__c != oldMap.get(timeCardId).Tuesday_Hours__c)) {
                    newMap.get(timeCardId).addError('You can not edit monday-tuesday hours');
                }else if (startDate + 3 == startDayOfMonth && (newMap.get(timeCardId).Monday_Hours__c != oldMap.get(timeCardId).Monday_Hours__c || newMap.get(timeCardId).Tuesday_Hours__c != oldMap.get(timeCardId).Tuesday_Hours__c || newMap.get(timeCardId).Wednesday_Hours__c != oldMap.get(timeCardId).Wednesday_Hours__c)) {
                    newMap.get(timeCardId).addError('You can not edit monday-wednesday hours');
                }else if (startDate + 4 == startDayOfMonth && (newMap.get(timeCardId).Monday_Hours__c != oldMap.get(timeCardId).Monday_Hours__c || newMap.get(timeCardId).Tuesday_Hours__c != oldMap.get(timeCardId).Tuesday_Hours__c || newMap.get(timeCardId).Wednesday_Hours__c != oldMap.get(timeCardId).Wednesday_Hours__c || newMap.get(timeCardId).Thursday_Hours__c != oldMap.get(timeCardId).Thursday_Hours__c)) {
                    newMap.get(timeCardId).addError('You can not edit monday-thursday hours');
                }else if (startDate + 5 == startDayOfMonth && (newMap.get(timeCardId).Monday_Hours__c != oldMap.get(timeCardId).Monday_Hours__c || newMap.get(timeCardId).Tuesday_Hours__c != oldMap.get(timeCardId).Tuesday_Hours__c || newMap.get(timeCardId).Wednesday_Hours__c != oldMap.get(timeCardId).Wednesday_Hours__c || newMap.get(timeCardId).Thursday_Hours__c != oldMap.get(timeCardId).Thursday_Hours__c || newMap.get(timeCardId).Friday_Hours__c != oldMap.get(timeCardId).Friday_Hours__c)) {
                    newMap.get(timeCardId).addError('You can not edit monday-friday hours');
                }else if (startDate + 6 == startDayOfMonth && (newMap.get(timeCardId).Monday_Hours__c != oldMap.get(timeCardId).Monday_Hours__c || newMap.get(timeCardId).Tuesday_Hours__c != oldMap.get(timeCardId).Tuesday_Hours__c || newMap.get(timeCardId).Wednesday_Hours__c != oldMap.get(timeCardId).Wednesday_Hours__c || newMap.get(timeCardId).Thursday_Hours__c != oldMap.get(timeCardId).Thursday_Hours__c || newMap.get(timeCardId).Friday_Hours__c != oldMap.get(timeCardId).Friday_Hours__c  || newMap.get(timeCardId).Saturday_Hours__c != newMap.get(timeCardId).Saturday_Hours__c)) {
                    newMap.get(timeCardId).addError('You can not edit monday-saturday hours');
                }
            }

            else {
                if (newMap.get(timeCardId).Monday_Hours__c != oldMap.get(timeCardId).Monday_Hours__c || newMap.get(timeCardId).Tuesday_Hours__c != oldMap.get(timeCardId).Tuesday_Hours__c || newMap.get(timeCardId).Wednesday_Hours__c != oldMap.get(timeCardId).Wednesday_Hours__c || newMap.get(timeCardId).Thursday_Hours__c != oldMap.get(timeCardId).Thursday_Hours__c || newMap.get(timeCardId).Friday_Hours__c != oldMap.get(timeCardId).Friday_Hours__c  || newMap.get(timeCardId).Saturday_Hours__c != newMap.get(timeCardId).Saturday_Hours__c)
                    newMap.get(timeCardId).addError('This record can not be inserted');
            }
        }
    }

}