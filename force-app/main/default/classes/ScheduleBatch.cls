global class ScheduleBatch implements Schedulable {

    // Utilisation du Batch toutes les semaines
   global void execute(SchedulableContext sc) {
      Database.executeBatch(new UpdateAccountsTurnoverBatch());
   }
}