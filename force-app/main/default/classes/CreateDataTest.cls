@isTest
public class CreateDataTest {
    
    	// Remplissage de données de test ( création de nbAccount Compte ayant chacun nbOrder commande)
    	static public void createAccountOrder(Integer nbAccount, Integer nbOrder) {
        
            
            // Création d'un produit (obligatoire pour créer un PricebookEntry)
            Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        	Insert pd1;
            
            // Création d'un PricebookEntry (obligatoire pour créer des OrderItem)
            PricebookEntry pbe = new PricebookEntry(
            	Pricebook2Id = Test.getStandardPricebookId(),
            	Product2Id = pd1.Id,
            	UnitPrice = 1020,
            	IsActive = true
        	);
        	Insert pbe;
            
            // Création d'une variable qui englobera tous les comptes que l'on aura créés
            Account[] acc = new Account[]{};
                
            for(integer i = 0; i < nbAccount; i++){
                // Création de nbAccount compte ayant chacun des noms différents
                acc.add(new Account(Name = 'Account'+(i+1)));
            }
            // Insertion de tous les comptes dans le système en même temps
            insert acc;
            
            // Création d'une variable qui englobera toutes les commandes que l'on aura créées
            Order[] ord = new Order[]{};
            
            for(integer i = 0; i < acc.size(); i++){
                for(integer j =0; j < nbOrder; j++){
                    // Création de nbOrder commande par compte ayant chacun des noms différents
                    ord.add(new Order(
                        AccountId = acc[i].Id,
                        EffectiveDate = Date.today(), 
                        Status='Draft',
                        Pricebook2Id = Test.getStandardPricebookId(),
                        Name = 'Account'+(i+1)+'Order'+(j+1)));
                }
            }
            // Insertion de toutes les commandes dans notre système
            insert ord;
			
            // Création de 2 OrderItem par commande et insertion de toutes celle-ci
            OrderItem[] ordItem = new OrderItem[]{};
                
            ordItem.add(new OrderItem (OrderId = ord[0].Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 100));
            ordItem.add(new OrderItem (OrderId = ord[0].Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000));
            for(Integer i = 1; i < ord.size(); i++ ){
                ordItem.add(new OrderItem (OrderId = ord[i].Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 1000));
                ordItem.add(new OrderItem (OrderId = ord[i].Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 10000));
            }
            insert ordItem;        
		}
    
}