public class AccountTurnoverClass {
    static public void calculateTurnover(Account[] accountToUpdate){
        
        system.debug(accountToUpdate.size());
        for(integer i=0; i < accountToUpdate.size(); i++){
            Order[] listOrders =  accountToUpdate[i].Orders;
           for(integer j=0; j < listOrders.size(); j++){
               // Ajout du prix de la commande au chiffre d'affaires du compte associé
               accountToUpdate[i].Turnover__c = accountToUpdate[i].Turnover__c + listOrders[j].TotalAmount;
           }
       }
       update accountToUpdate;
    }
}