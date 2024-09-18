global class UpdateAccountsTurnoverBatch implements Database.Batchable<sObject>{
    
   global Database.QueryLocator start(Database.BatchableContext info){ 
       //Requête seulement les comptes qui ont au moins une commande avec le statut 'Ordered' 
       return Database.getQueryLocator('SELECT Id, Turnover__c, Name, (SELECT TotalAmount, Id FROM Orders WHERE Status = \'Ordered\') FROM Account');

   }
    
   global void execute(Database.BatchableContext info, Account[] accountToUpdate){      
       
       // Nous passons donc par une variable récupérant toutes les données que nous devions avoir pour ne pas être bloqués à 200 commandes
       Account[] acc = [SELECT Id, Turnover__c, Name, (SELECT TotalAmount, Id FROM Orders WHERE Status = 'Ordered' ) FROM Account WHERE Id IN :accountToUpdate];
		
       // Nous remettons le chiffre d'affaires à 0 avant de le recalculer
       for(integer i=0; i < accountToUpdate.size(); i++){
			acc[i].Turnover__c=0;
       }
       
       // Calcul du chiffre d'affaires       
       AccountTurnoverClass.calculateTurnover(acc);
   }    
    
   global void finish(Database.BatchableContext info){     
       
   } 
}