trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    
    if(trigger.isInsert || trigger.isUpdate){
        List<task> newTasks = new List<Task>();
        for(opportunity opp : trigger.new){
            if(opp.stageName == 'Closed Won'){
                Task t = new Task(Subject='Follow Up Test Task');
                newTasks.add(t);
            }
        }
        
        insert newTasks;
    }
   
  
}