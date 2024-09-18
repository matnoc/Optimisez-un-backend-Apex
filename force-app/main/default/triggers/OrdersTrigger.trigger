trigger OrdersTrigger on Order (after update, before update) {
    system.debug('est entrer ici');
    if(trigger.isUpdate){
        if(trigger.isBefore){
            OrdersTriggerClass.beforeUpdate(trigger.new);
        }
        else{
            OrdersTriggerClass.afterUpdate(trigger.old, trigger.new);
        }
    }
}