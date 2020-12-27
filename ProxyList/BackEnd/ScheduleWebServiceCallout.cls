Execution:-

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
