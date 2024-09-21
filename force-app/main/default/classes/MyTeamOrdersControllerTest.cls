@isTest
public class MyTeamOrdersControllerTest {

    @isTest
    static void test(){
        CreateDataTest.createAccountOrder(3,5);
         Order[] ord = [SELECT Id, TotalAmount, Status FROM Order];
        for(integer i = 0; i<ord.size(); i++){
            ord[i].Status = 'Ordered';
        }
        update ord;
        MyTeamOrdersController mtoc = new MyTeamOrdersController();
        Assert.areEqual(mtoc.SumOders, 14*210000+21000);
        
    }
}