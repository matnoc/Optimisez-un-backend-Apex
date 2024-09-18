@isTest
private class OrdersTriggerTest {
        
    // Tester le Trigger pour 1 Compte possèdant 1 commande
    @isTest 
    static void test1Order1Account() {
        CreateDataTest.createAccountOrder(1,1);
        Order ord = [SELECT Id, TotalAmount FROM Order WHERE Name ='Account1Order1'];
        ord.Status = 'Ordered';
        
        Test.startTest();
        	update ord;
          Test.stopTest();
        
        Account[] acc = [SELECT Id, Turnover__c, Name FROM Account WHERE Name = 'Account1'];
        system.debug(acc[0].Turnover__c);
        Assert.areEqual(21000, acc[0].Turnover__c);
    }
    
    // Tester le Trigger pour 1 Compte possèdant 2 commandes update en même temps
    @isTest 
    static void testUpdate2Order1Account() {
        CreateDataTest.createAccountOrder(1,2);
        Order[] ord = [SELECT Id, TotalAmount, Status FROM Order WHERE Name LIKE 'Account1%'];
        for(integer i = 0; i < ord.size(); i++){
            ord[i].Status = 'Ordered';
        }
        
        Test.startTest();
        	update ord;
          Test.stopTest();
        
        Account[] acc = [SELECT Id, Turnover__c, Name FROM Account WHERE Name = 'Account1'];
        system.debug(acc[0].Turnover__c);
        Assert.areEqual(231000, acc[0].Turnover__c);
    }
    
    
    // Tester le Trigger pour 1 Compte possèdant 2 commandes mais n'ayant qu'une seule étant update
     @isTest 
    static void test2Order1Account() {
        CreateDataTest.createAccountOrder(1,2);
        Order[] ord = [SELECT Id, TotalAmount, Status FROM Order ORDER BY Name ASC];
            ord[0].Status = 'Ordered';
         	ord[0].ShipmentCost__c = 10000;
         	ord[1].ShipmentCost__c = 10000;
        
         Test.startTest();
        	update ord;
          Test.stopTest();
        Order[] ord1 = [SELECT Id, NetAmount__c FROM Order ORDER BY Name ASC];
        Account[] acc = [SELECT Id, Turnover__c, Name FROM Account WHERE Name = 'Account1'];
        Assert.areEqual(21000, acc[0].Turnover__c);
        Assert.areEqual(11000, ord1[0].NetAmount__c);
        Assert.areEqual(200000, ord1[1].NetAmount__c);
    }
    
    // Mettre à jour des commandes sur des comptes différents
    @isTest 
    static void test2Account() {
        CreateDataTest.createAccountOrder(2,1);
        Order[] ord = [SELECT Id, TotalAmount, Status FROM Order];
        for(integer i = 0; i<ord.size(); i++){
            ord[i].Status = 'Ordered';
        }
        
        Test.startTest();
        	update ord;
          Test.stopTest();
        
        Account [] acc = [SELECT Id, Turnover__c, Name FROM Account ORDER BY Name ASC];
        Assert.areEqual(21000, acc[0].Turnover__c);
        Assert.areEqual(210000, acc[1].Turnover__c);
    }
    
    
    //Mettre à jour plus de 200 commandes
    @isTest 
    static void test250Order() {
        CreateDataTest.createAccountOrder(1,250);
        Order[] ord = [SELECT Id, TotalAmount, Status FROM Order];
        for(integer i = 0; i<ord.size(); i++){
            ord[i].Status = 'Ordered';
        }
        
        Test.startTest();
        	update ord;
          Test.stopTest();
        
        Account [] acc = [SELECT Id, Turnover__c, Name FROM Account ORDER BY Name ASC];
    	Assert.areEqual(21000+210000*249, acc[0].Turnover__c);
    }
    
}