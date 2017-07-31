public class DailyLeadProcessor implements Schedulable 
{
    public void execute(SchedulableContext sc) 
    {
        List<Lead> lList = [Select Id, LeadSource from Lead where LeadSource = null limit 200];
        List<lead> led = new list<lead>();
        if(!lList.isEmpty()) 
        {
            for(Lead l: lList) 
            {
                l.LeadSource = 'Dreamforce';
                led.add(l);
            }
            Database.update(led);
        }
    }
}