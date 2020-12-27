public class ScheduleDeleteServerDataCallout implements Schedulable{
	 public void execute(SchedulableContext scContext)
     {
        // Call Pub Proxy API
        DeleteProxyList.deletePubProxyListFromDB();
        
        // Call Proxy11 API
        DeleteProxyList.deleteProxy11ListFromDB();
         
        // Call GetProxy API
        DeleteProxyList.deleteGetProxyListFromDB();
         
        // Call  GimmeProxy API 
        DeleteProxyList.deleteGimmeListFromDB();
        
        // Call ByteProxy API
        DeleteProxyList.deleteByteProxyListFromDB();
                
    }
}
/*
 * APEX Query To Schedule API Callout For Every 9 Min 55 Seconds
 * 
String sch1 = '55 59 * * * ?';
ScheduleDeleteServerDataCallout sqrb1 = new ScheduleDeleteServerDataCallout();
system.schedule('Every Hour Plus 59 Min 55 Sec', sch1, sqrb1); 
String sch2 = '55 9 * * * ?';
ScheduleDeleteServerDataCallout sqrb2 = new ScheduleDeleteServerDataCallout();
system.schedule('Every Hour plus 9 Min 55 Sec', sch2, sqrb2); 
String sch3 = '55 19 * * * ?';
ScheduleDeleteServerDataCallout sqrb3 = new ScheduleDeleteServerDataCallout();
system.schedule('Every Hour plus 19 Min 55 Sec', sch3, sqrb3);
String sch4 = '55 29 * * * ?';
ScheduleDeleteServerDataCallout sqrb4 = new ScheduleDeleteServerDataCallout();
system.schedule('Every Hour plus 29 Min 55 Sec', sch4, sqrb4);
String sch5 = '55 39 * * * ?';
ScheduleDeleteServerDataCallout sqrb5 = new ScheduleDeleteServerDataCallout();
system.schedule('Every Hour plus 39 Min 55 Sec', sch5, sqrb5);
String sch6 = '55 49 * * * ?';
ScheduleDeleteServerDataCallout sqrb6 = new ScheduleDeleteServerDataCallout();
system.schedule('Every Hour plus 49 Min 55 Sec', sch6, sqrb6);

*/