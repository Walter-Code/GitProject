trigger CheckingChunksOfTrigger on Invoice_Statement__c (before update) {
	Savepoint sp = Database.setSavePoint();
    
    Invoice_Statement__c ins = new Invoice_Statement__c();
    insert ins;
    if(ins.Description__c != null){
        Database.rollback(sp);
    }
}