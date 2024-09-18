@isTest
public class MyTeamOrdersControllerTest {

    @isTest
    static void test(){
        CreateDataTest.createAccountOrder(3,5);
        MyTeamOrdersController mtoc = new MyTeamOrdersController();
        List<Order> ord = mtoc.getOrders();
        Assert.areEqual(ord.size(), 3*15);
        
    }
}