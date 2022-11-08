trigger LogoutEventTrigger on LogoutEventStream (after insert) {
	
    LogoutEventStream event = Trigger.new[0];
    LogoutEventTriggerHelper.httpServiceMethod();
}