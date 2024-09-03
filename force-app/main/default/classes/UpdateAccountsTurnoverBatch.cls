global class UpdateAccountsTurnoverBatch implements Database.Batchable<sObject>{
    
   global Database.QueryLocator start(Database.BatchableContext info){ 
       //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered' ou 'Activated'
       String str = 'Draft';  //passage par une variable pour l'insérer dans la requette
       return Database.getQueryLocator('SELECT Id, Turnover__c, Name, (SELECT TotalAmount, Id FROM Orders WHERE Status != :str) FROM Account');

   }
    
   global void execute(Database.BatchableContext info, Account[] accountToUpdate){      
       
       // Les données reçue via le Batch étant Aggregate, ils nous est impossible d'extraire les commande si le compte en possèdent plus de 200
       // Nous passons donc par une variable récupérant toute les données que nous devions avoir
       Account[] acc = [SELECT Id, Turnover__c, Name, (SELECT TotalAmount, Id FROM Orders WHERE Status != : 'Draft' ) FROM Account WHERE Id IN :accountToUpdate];
		
       // Nous remettons le chiffre d'affaire à 0 avant de le recalculé
       for(integer i=0; i < accountToUpdate.size(); i++){
			acc[i].Turnover__c=0;
       }
       
       // Calcule du chiffre d'affaire       
       AccountTurnoverClass.calculateTurnover(acc);
   }    
    
   global void finish(Database.BatchableContext info){     
       
   } 
}