@IsTest
public class UpdateAccountsTurnoverBatchTest {

    
    // Test du bon fonctionnement du batch
    @IsTest
    public static void testBatchWithSchedule(){
        CreateDataTest.createAccountOrder(1,250);
        Order[] ord = [SELECT Id,TotalAmount FROM Order ORDER BY Name ASC];
        
        //Les commande doivent avoir un statu différent de Draft
        for(integer i = 0; i < ord.size(); i++){
            ord[i].Status='Ordered';
        }
        update ord;
  
        OrderItem[] ordItem = [SELECT Id, UnitPrice FROM OrderItem WHERE OrderId = :ord[0].Id];
        
        // Nous changeons le prix d'une des commande afin d'observer si le batch prend en compte le changement
        for(integer j=0; j < ordItem.size(); j++){
            ordItem[j].UnitPrice = ordItem[j].UnitPrice * 10;
        }
        update ordItem;
        system.debug(ord[0].TotalAmount);
        Test.startTest();
        Database.executeBatch(new UpdateAccountsTurnoverBatch());
        Test.stopTest();
        Account[] acc = [SELECT Id, Turnover__c, Name FROM Account WHERE Name = 'Account1'];
        Assert.areEqual(210000*250, acc[0].Turnover__c);
    }
}