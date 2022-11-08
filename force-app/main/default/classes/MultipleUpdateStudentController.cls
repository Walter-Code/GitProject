public class MultipleUpdateStudentController {
    public String op{get;set;}
    Integer count;
    //enum operate{EQUAL,GREATER_THAN,GREATER_THAN_EQUAL,LESS_THAN,LESS_THAN_EQUAL,NOT_EQUAL}
    public List<Student__c> studentsTemp{get;set;}
    public String FirstName{get;set;}
    public Student__c st{get;set;}
    public List<Student__C> students{get;set;}
    public MultipleUpdateStudentController(){
        count = 0;
        st = new Student__c();
        studentsTemp = new List<Student__c>();
        students = [Select Id, First_Name__c,Date_Of_Birth__c,Sex__c,Class__c,Have_Vehicle__c from Student__c];
    }
    
    public PageReference save(){
        try{
            if(students.size()>0){
             	upsert students;   
            }
            delete studentsTemp;
        }catch(Exception ex){
           	ApexPages.addMessages(ex);
        }
        studentsTemp = new List<Student__c>();
        return new PageReference('/apex/MultipleUpdateStudent');
        
    }
    
    public void AddStudent(){
        students.add(new Student__c());
        count++;
    }
    
    public void RemoveRow(){
        if(count==0){
            studentsTemp.add(students.remove(students.size()-1));
        }
        else{
            students.remove(students.size()-1);
        	count--;
        }
    }
    
    public void search(){
        Date myDate = st.Date_Of_Birth__c;
        String query = 'Select Id, First_Name__c,Date_Of_Birth__c,Sex__c,Class__c,Have_Vehicle__c from Student__c where Id !=null ';
        if(string.isNotBlank(FirstName)){
            String fName = '%'+ FirstName + '%';
            query += ' AND First_Name__c like :fName';
        }
        if(st.Date_Of_Birth__c != null){
            query += ' AND Date_Of_Birth__c '+ op + ' :myDate';
        }
        students = Database.query(query);
	}
}