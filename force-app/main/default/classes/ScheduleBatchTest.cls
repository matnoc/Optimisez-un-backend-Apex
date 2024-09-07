@IsTest
public class ScheduleBatchTest {
    
    //Test du lancement du Schedule
    @IsTest
    public static void testSchedule(){
        String CRON_EXP ='0 0 0 15 3 ? 2025';
        Test.startTest();
        String scheduleId = System.schedule('ScheduleBatch', CRON_EXP,new ScheduleBatch());
        Test.stopTest();
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
                              FROM CronTrigger WHERE id = :scheduleId];
        System.assertEquals(CRON_EXP, 
                                ct.CronExpression);
            System.assertEquals(0, ct.TimesTriggered);
            System.assertEquals('2025-03-15 00:00:00', 
                                String.valueOf(ct.NextFireTime));
    }

}