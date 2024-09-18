public class OrdersTriggerClass {

    public static void beforeUpdate(Order[] ordAfter){
        for(integer i=0; i<ordAfter.size(); i++){
            if(ordAfter[i].ShipmentCost__c == null) {
                ordAfter[i].ShipmentCost__c = 0;
            }
        	ordAfter[i].NetAmount__c = ordAfter[i].TotalAmount - ordAfter[i].ShipmentCost__c;
        }
    }
    
    
    
    public static void afterUpdate(Order[] ordBefore, Order[] ordAfter){
         // Création d'une variable définissant les commandes à traiter
    Order[] orderToUpdate = new Order[]{};
        
    // Parcours de toutes les commandes ayant déclenché le Trigger
    for(integer i=0; i<ordAfter.size(); i++){
        // Prise en compte uniquement des commandes ayant changé de statut de Draft à Ordered
        if (ordBefore[i].Status == 'Draft' && ordAfter[i].Status == 'Ordered' ){
            orderToUpdate.add(ordAfter[i]);
        }
    }
    
    // Regrouper les commandes prises en compte avec le compte qui leur est associé
    Account[] accountToUpdate = [SELECT Id, Turnover__c, Name, (SELECT TotalAmount, Id FROM Orders WHERE Id IN : orderToUpdate ) FROM Account];
    
    // Calcul du chiffre d'affaires
    AccountTurnoverClass.calculateTurnover(accountToUpdate);
    }
}