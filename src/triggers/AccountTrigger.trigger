trigger AccountTrigger on Account (
	before insert, 
	before update, 
	before delete, 
	after insert, 
	after update, 
	after delete, 
	after undelete
) {


	System.debug('Trigger.new ' + Trigger.new);
	System.debug('Trigger.newMap ' + Trigger.newMap);
	System.debug('Trigger.old ' + Trigger.old);
	System.debug('Trigger.oldMap ' + Trigger.oldMap);
	System.debug('Trigger.isBefore ' + Trigger.isBefore);
	System.debug('Trigger.isAfter ' + Trigger.isAfter);


	//if(Trigger.IsBefore && Trigger.isInsert) {
	//	AccountTriggerHelper.handleBeforeInsert(Trigger.new);
	
	//} else if(Trigger.isAfter && Trigger.isInsert) {
	//	AccountTriggerHelper.handleAfterInsert(Trigger.new, Trigger.oldMap);
	
	//} else if(Trigger.isBefore && Trigger.isUpdate) {
	//	AccountTriggerHelper.handleBeforeUpdate(Trigger.new, Trigger.oldMap);

	//} else 

	if(Trigger.isAfter && Trigger.isUpdate) {
		AccountTriggerHelper.handleAfterUpdate(Trigger.new, Trigger.oldMap);

	}


}