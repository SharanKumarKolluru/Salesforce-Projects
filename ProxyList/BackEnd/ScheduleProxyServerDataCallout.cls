public class ScheduleProxyServerDataCallout implements Schedulable{
	 public void execute(SchedulableContext scContext)
     {
        // Call Pub Proxy API
        PubProxyDataCallOut.makePubProxyDataCallout();
        
        // Call Proxy11 API
        Proxy11DataCallOut.makeProxy11DataCallout();
         
        // Call GetProxy API
        GetProxyDataCallout.makeGetProxyDataCallout();
         
        // Call  GimmeProxy API 
        GimmeProxyDataCallout.makeGimmeProxyDataCallout();
        
        // Call ByteProxy API
        ByteProxyDataCallout.makeByteProxyDataCallout();
                
    }
}

/*
APEX Query To Schedule API Callout For Every 10 Min
        
        String sch1 = '0 0 * * * ?';
		ScheduleProxyServerDataCallout sqrb1 = new ScheduleProxyServerDataCallout();
		system.schedule('Every Hour plus 0 min', sch1, sqrb1); 
		String sch2 = '0 10 * * * ?';
		ScheduleProxyServerDataCallout sqrb2 = new ScheduleProxyServerDataCallout();
		system.schedule('Every Hour plus 10 min', sch2, sqrb2); 
		String sch3 = '0 20 * * * ?';
		ScheduleProxyServerDataCallout sqrb3 = new ScheduleProxyServerDataCallout();
		system.schedule('Every Hour plus 20 min', sch3, sqrb3);
		String sch4 = '0 30 * * * ?';
		ScheduleProxyServerDataCallout sqrb4 = new ScheduleProxyServerDataCallout();
		system.schedule('Every Hour plus 30 min', sch4, sqrb4);
		String sch5 = '0 40 * * * ?';
		ScheduleProxyServerDataCallout sqrb5 = new ScheduleProxyServerDataCallout();
		system.schedule('Every Hour plus 40 min', sch5, sqrb5);
		String sch6 = '0 50 * * * ?';
		ScheduleProxyServerDataCallout sqrb6 = new ScheduleProxyServerDataCallout();
		system.schedule('Every Hour plus 50 min', sch6, sqrb6);
		
*/
/*
global class ScheduleProxyServerDataCallout implements Schedulable{
    global void execute(SchedulableContext SC) {
        PubProxyDataCallOut.makePubProxyDataCallout();   
        String day = string.valueOf(system.now().day());
        String month = string.valueOf(system.now().month());
        String hour = string.valueOf(system.now().hour());
        String minute = string.valueOf(system.now().minute() + 10);
        String second = string.valueOf(system.now().second());
        String year = string.valueOf(system.now().year());
        
        String strJobName = 'Job-' + second + '_' + minute + '_' + hour + '_' + day + '_' + month + '_' + year;
        String strSchedule = '0 ' + 10 + ' ' + hour + ' ' + day + ' ' + month + ' ?' + ' ' + year;
        System.schedule(strJobName, strSchedule, new ScheduleProxyServerDataCallout());
    } 
}

*/