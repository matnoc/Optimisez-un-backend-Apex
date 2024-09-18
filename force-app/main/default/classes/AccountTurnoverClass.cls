public class AccountTurnoverClass {
    static public void calculateTurnover(Account[] accountToUpdate){
        
        system.debug(accountToUpdate.size());
        for(integer i=0; i < accountToUpdate.size(); i++){
            Order[] listOrders =  accountToUpdate[i].Orders;
           for(integer j=0; j < listOrders.size(); j++){
               // Si le chiffre d'affaire est nul, remise à 0 de celui ci
               if(accountToUpdate[i].Turnover__c == null){
                   accountToUpdate[i].Turnover__c = 0;
               }
               // Ajout du prix de la commande au chiffre d'affaires du compte associé
               accountToUpdate[i].Turnover__c = accountToUpdate[i].Turnover__c + listOrders[j].TotalAmount;
           }
       }
       update accountToUpdate;
    }
}