public class StudentModelController {
    public List<StudentModel> studentModels {get;set;}
    public StudentModelController(){
        studentModels = new List<StudentModel>();
        integer i = 0;
        for(Student__c stu : [Select Id, First_Name__c, Name, Date_Of_Birth__c,Sex__c,Class__c,Have_Vehicle__c from Student__c]){
            StudentModel sm = new StudentModel();
            sm.stu = stu;
            sm.sno = ++i;
            sm.isChecked = false;
            studentModels.add(sm);
        }    
    }
    
    class StudentModel{
        public boolean isChecked{get;set;}
        public Student__c stu{get;set;}
        public Integer sno{get;set;}
    }
    
    public PageReference save(){
        List<Student__c> updateStudents = new List<Student__c>();
        for(StudentModel sm : studentModels){
            System.debug(sm);
            if(sm.isChecked){
                System.debug(sm.stu);
                updateStudents.add(sm.stu);
            }
        }
        upsert updateStudents;
        PageReference pg = new PageReference('/apex/StudentModelDemo');
        pg.setRedirect(true);
        return pg;
        
    }
}