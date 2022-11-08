trigger CustomerTrigger on Customer__c (before insert, before update) {
	System.debug('Trigger Executed When Roll Up');
}