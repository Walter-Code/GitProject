@isTest
public class UserEmailVerificationBatchTest {
    
    @isTest(seeAlldata=true)
    static void testUserEmailVerificationBatch(){
        Database.executeBatch(new UserEmailVerificationBatch());
    }
}