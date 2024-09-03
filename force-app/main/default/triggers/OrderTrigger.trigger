trigger OrderTrigger on Order (after update) {
	
    // Création d'une variable définissant les commande à traité
    Order[] orderToUpdate = new Order[]{};
        
    // Parcourt de toutes les commande ayant déclancher le Trigger
    for(integer k=0; k<trigger.new.size(); k++){
        
        // Prise en compte uniquement des commandes ayant changer de status de Draft à autre choses
        if (trigger.old[k].Status == 'Draft' && trigger.new[k].Status != 'Draft' ){
        	orderToUpdate.add(trigger.new[k]);
        }
    }
    
    // Regrouper les commandes prises en compte avec le compte qui leurs est associé
    Account[] accountToUpdate = [SELECT Id, Turnover__c, Name, (SELECT TotalAmount, Id FROM Orders WHERE Id IN : orderToUpdate ) FROM Account];
    
    // Calcule du chiffre d'affaire
    AccountTurnoverClass.calculateTurnover(accountToUpdate);
}