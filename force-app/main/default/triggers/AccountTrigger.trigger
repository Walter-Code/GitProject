/******************************************************************************************************************
Trigger Name       : AccountTrigger
Description        : Trigger on account used to update forecast fields.
Organization       :  

Revision History   :-
Version             Date            Author                
1.0                 7/15/2021         
*******************************************************************************************************************/
//Added after update only because wants to run trigger only when its value gets updated.
trigger AccountTrigger on Account (after update) {
	
    if(trigger.isAfter && trigger.isUpdate){
        AccountTriggerHandler.updateForeCast(trigger.new, trigger.oldMap);
    }
}