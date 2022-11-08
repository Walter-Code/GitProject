@isTest
public class SendEmailControllerTest {
	
    @isTest static void sendMailTest(){
        String subject = 'Test Email To Case';
        String body = '<p><img src="https://tlcm-dev-ed--c.documentforce.com/servlet/rtaImage?refid=0EM5e000000kJvs"></p>';
        String result = SendEmailController.sendMail(subject, body);
        System.assertEquals('Email Sent Successfully', result);
    }
}