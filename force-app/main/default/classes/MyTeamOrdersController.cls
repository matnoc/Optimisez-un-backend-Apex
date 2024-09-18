public without sharing class MyTeamOrdersController {
    
    public List<Order> getOrders() {
    	List<Order> results = Database.query(
        	'SELECT Id, Name, AccountId, TotalAmount, OwnerId ' +
        	'FROM Order ' +
        	'ORDER BY OwnerId ASC '
    	);
    return results;
	}
    
    
}