public with sharing class CalculatePrepClass {
    public CalculatePrepClass() {

    }

    public class Wrapper {
        String range;
        Integer value;

        public Wrapper (String range, Integer value) {
            this.range = range;
            this.value = value;
        }
    }

    public static void calculatePrep(List<Allotment__c> allotmentList){
        Set<Id> teachingLoadId = new Set<Id>();
        Map<String,Decimal> staticPrepValues = new Map<String,Decimal>();
        staticPrepValues.put('1-5',0.5);
        staticPrepValues.put('6-10',0.5);
        staticPrepValues.put('1-10',1);
        staticPrepValues.put('1-12',1);
        staticPrepValues.put('1-3',0.25);
        staticPrepValues.put('4-6',0.25);
        staticPrepValues.put('7-9',0.25);
        staticPrepValues.put('10-12',0.25);
        staticPrepValues.put('1-6',0.5);
        staticPrepValues.put('7-12',0.5);
        staticPrepValues.put('1-9',0.75);
        
        for(Allotment__c alt:allotmentList){
            if(alt.Vf_Allotment_Lock__c ==false && alt.Lock__c ==false){
                teachingLoadId.add(alt.Teaching_Load__c);
            }
        }
        
        //Map to hold the prep hours corresponding to Teaching Load
        Map<Id, Decimal> teachingLoadToPrephours = new Map<Id, Decimal> ();

        //Child to parent query to get the allotments based on TeachingLoadIds
        List<Allotment__c> allotments = [SELECT Id, Teaching_Load__c, Course__c, No_of_Sections_Preferred__c, Preferred_Sessions__c FROM Allotments__r WHERE Course_Type_F__c != 'Practicum' AND Teaching_Load__c IN :teachingLoadId];

        //Map of Teaching Load to Map of Course to the heighest range value
        Map<Id, Map<Id, Wrapper>> teachingLoadToCourseToMax = new Map<Id, Map<Id, Wrapper>> ();
  
        //Loop through the allotments
        for (Allotment__c alltInstance: allotments) {

            //Get the prefferred range
            String prefSession = !String.isBlank(alltInstance.No_of_Sections_Preferred__c) ? alltInstance.No_of_Sections_Preferred__c : (!String.isBlank(alltInstance.Preferred_Sessions__c) ? alltInstance.Preferred_Sessions__c : null); 

            //If there is the range
            if (prefSession != null) {

                //Get the rnge value, means the difference in the range
                List<String> prefSessionSplitted = prefSession.split('-');
                Integer RangeValue = Integer.valueOf(prefSessionSplitted[1]) - Integer.valueOf(prefSessionSplitted[0]);

                //Compare with the already present range value and update, so that at the end, heighest range difference one will be present in the map
                if (teachingLoadToCourseToMax.containsKey(alltInstance.Teaching_Load__c)) {
                    if (teachingLoadToCourseToMax.get(alltInstance.Teaching_Load__c).containsKey(alltInstance.Course__c)) {
                        if (teachingLoadToCourseToMax.get(alltInstance.Teaching_Load__c).get(alltInstance.Course__c).value < RangeValue){
                            teachingLoadToCourseToMax.get(alltInstance.Teaching_Load__c).put(alltInstance.Course__c, new Wrapper(alltInstance.No_of_Sections_Preferred__c, RangeValue));
                        }
                    }else {
                        teachingLoadToCourseToMax.get(alltInstance.Teaching_Load__c).put(alltInstance.Course__c, new Wrapper(alltInstance.No_of_Sections_Preferred__c, RangeValue));
                    }
                }else {
                    teachingLoadToCourseToMax.put(alltInstance.Teaching_Load__c, new Map<Id, Wrapper> {alltInstance.Course__c => new Wrapper(alltInstance.No_of_Sections_Preferred__c, RangeValue)});
                }
            }

        }

        //Loop through the teaching loads in the constitued map
        for (Id teachingLoadId: teachingLoadToCourseToMax.keySet()) {
            //Loop through the courses map present for each teaching load
            for (Id courseId: teachingLoadToCourseToMax.get(teachingLoadId).keySet()) {
                //Increment the total prep hours map corresponding to each teaching load
                if(staticPrepValues.get(teachingLoadToCourseToMax.get(teachingLoadId).get(courseId).range) != NULL){
                    if (teachingLoadToPrephours.containsKey(teachingLoadId)) {
                        teachingLoadToPrephours.put(teachingLoadId, teachingLoadToPrephours.get(teachingLoadId) + staticPrepValues.get(teachingLoadToCourseToMax.get(teachingLoadId).get(courseId).range));
                    }else {
                        teachingLoadToPrephours.put(teachingLoadId, staticPrepValues.get(teachingLoadToCourseToMax.get(teachingLoadId).get(courseId).range));
                    }
                }
            }
        }

        //List to hold the teaching loads to be updated
        List<Teaching_Load__c> teachingLoadsToUpdate = new List<Teaching_Load__c> ();

        //Create teaching load records with updated prep hours
        for (Id teachingLoadId: teachingLoadToPrephours.keySet()) {
            teachingLoadsToUpdate.add(new Teaching_Load__c(Id = teachingLoadId, Prep__c=teachingLoadToPrephours.get(teachingLoadId)));
        }

        //Update the teaching loads
        update teachingLoadsToUpdate;
        
        
        
        
        
        
        
        
        
        
        
        Map<Id,List<Allotment__c>> teachingLoadwithAllotmentMap = new Map<Id,List<Allotment__c>>();
        List<Teaching_Load__c> teachingLoadwithAllAllotments = [Select Id,Name,Prep__c,(select Id,Name,Vf_Allotment_Lock__c,Lock__c,Teaching_Load__c,Course__c,No_of_Sections_Preferred__c,Preferred_Sessions__c,Course_Type_F__c From Allotments__r Where Course_Type_F__c!='Practicum' and Vf_Allotment_Lock__c=false and Lock__c =false) From Teaching_Load__c WHERE Id In:teachingLoadId];
        //List<Allotment__c> allAllotmentList = [select Id,Name,Teaching_Load__c,Course__c,No_of_Sections_Preferred__c From Allotment__c Where Teaching_Load__c IN:teachingLoadId];
        
        
        Map<Id,Teaching_Load__c> mapTeachingLoadById =new Map<Id,Teaching_Load__c>();
        for(Teaching_Load__c tec:teachingLoadwithAllAllotments){
            teachingLoadwithAllotmentMap.put(tec.Id,Tec.Allotments__r);
            mapTeachingLoadById.put(tec.Id, tec);
        }
        
        List<Teaching_Load__c> listTeachingLoads = new List<Teaching_Load__c>();
        for(Id key:teachingLoadwithAllotmentMap.keyset()){
            //List<Allotment__c> allotmentListForUpdate = teachingLoadwithAllotmentMap.get(key);
            Double prepHours = 0.0;
            Map<id,List<Allotment__c>> coursewithAllotmentsMap = new Map<id,List<Allotment__c>>();
            for(Allotment__c alt:teachingLoadwithAllotmentMap.get(key)){
                List<Allotment__c> alotList = new List<Allotment__c>();
                if(!coursewithAllotmentsMap.containsKey(alt.Course__c)){
                    alotList.add(alt);
                }
                else{
                    alotList = coursewithAllotmentsMap.get(alt.Course__c);
                    alotList.add(alt);
                }
                coursewithAllotmentsMap.put(alt.Course__c, alotList);
            }
            System.debug('CourseId=>Allot'+coursewithAllotmentsMap);
            if(!coursewithAllotmentsMap.isEmpty()){
                for (Id courseId : coursewithAllotmentsMap.keySet()) {
                    
                    if (coursewithAllotmentsMap.get(courseId).size()>1) {
                        List<String> sessionsList = new List<String>();
                        Integer bigRangeValue = -999; 
                        String selectedPrefferedSession = '';
                        for(Allotment__c allt:coursewithAllotmentsMap.get(courseId)){
                            if(allt.No_of_Sections_Preferred__c != Null && allt.Preferred_Sessions__c == NULL){
                                String prefSession = allt.No_of_Sections_Preferred__c;
                                List<String> prefSessionSplitted = prefSession.split('-');
                                Integer RangeValue = Integer.valueOf(prefSessionSplitted[1]) - Integer.valueOf(prefSessionSplitted[0]);
                                if (RangeValue > bigRangeValue) {
                                    bigRangeValue = RangeValue;
                                    selectedPrefferedSession = prefSession;
                                }
                            }
                            if(allt.No_of_Sections_Preferred__c == Null && allt.Preferred_Sessions__c != NULL){
                                String prefSession = allt.Preferred_Sessions__c;
                                List<String> prefSessionSplitted = prefSession.split('-');
                                Integer RangeValue = Integer.valueOf(prefSessionSplitted[1]) - Integer.valueOf(prefSessionSplitted[0]);
                                if (RangeValue > bigRangeValue) {
                                    bigRangeValue = RangeValue;
                                    selectedPrefferedSession = prefSession;
                                }
                            }
                            if(allt.No_of_Sections_Preferred__c != Null && allt.Preferred_Sessions__c != NULL){
                                String prefSession = allt.Preferred_Sessions__c;
                                List<String> prefSessionSplitted = prefSession.split('-');
                                Integer RangeValue = Integer.valueOf(prefSessionSplitted[1]) - Integer.valueOf(prefSessionSplitted[0]);
                                if (RangeValue > bigRangeValue) {
                                    bigRangeValue = RangeValue;
                                    selectedPrefferedSession = prefSession;
                                }
                            }
                            
                        }
                        if(staticPrepValues.get(selectedPrefferedSession)!=Null){
                            prepHours += staticPrepValues.get(selectedPrefferedSession);
                        }
                        
                    }
                    else if (coursewithAllotmentsMap.get(courseId).size() == 1 && (!String.isBlank(coursewithAllotmentsMap.get(courseId)[0].Preferred_Sessions__c) || !String.isBlank(coursewithAllotmentsMap.get(courseId)[0].No_of_Sections_Preferred__c)) ){
                        if(!String.isBlank(coursewithAllotmentsMap.get(courseId)[0].No_of_Sections_Preferred__c) && String.isBlank(coursewithAllotmentsMap.get(courseId)[0].Preferred_Sessions__c)){
                            if(staticPrepValues.get(coursewithAllotmentsMap.get(courseId)[0].No_of_Sections_Preferred__c) !=NULL){
                                prepHours += staticPrepValues.get(coursewithAllotmentsMap.get(courseId)[0].No_of_Sections_Preferred__c);
                            }
                        }
                        else if(!String.isBlank(coursewithAllotmentsMap.get(courseId)[0].Preferred_Sessions__c) && String.isBlank(coursewithAllotmentsMap.get(courseId)[0].No_of_Sections_Preferred__c)){
                            if(staticPrepValues.get(coursewithAllotmentsMap.get(courseId)[0].Preferred_Sessions__c) != Null){
                                prepHours += staticPrepValues.get(coursewithAllotmentsMap.get(courseId)[0].Preferred_Sessions__c);
                            }
                        }
                        else if(!String.isBlank(coursewithAllotmentsMap.get(courseId)[0].Preferred_Sessions__c) && !String.isBlank(coursewithAllotmentsMap.get(courseId)[0].No_of_Sections_Preferred__c)){
                            if(staticPrepValues.get(coursewithAllotmentsMap.get(courseId)[0].No_of_Sections_Preferred__c) != Null){
                                prepHours += staticPrepValues.get(coursewithAllotmentsMap.get(courseId)[0].No_of_Sections_Preferred__c);
                            }
                        }
                    }
                }
                System.debug('prepHours'+prepHours);
                Teaching_Load__c teachingLoad = mapTeachingLoadById.get(key);
                teachingLoad.Prep__c = prepHours;
                listTeachingLoads.add(teachingLoad);
                
            }
        }
        System.debug('TeachingLoad'+listTeachingLoads);
        if (listTeachingLoads.size()>0) {
            update listTeachingLoads;
        }
    }
}