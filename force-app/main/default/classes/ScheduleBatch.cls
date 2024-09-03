global class ScheduleBatch implements Schedulable {

    // Utilisation du Batch toute les semaine
   global void execute(SchedulableContext sc) {
      Database.executeBatch(new UpdateAccountsTurnoverBatch());
   }
}