/**
 * Created by new on 30.01.2018.
 */

public with sharing class testForCommunityClass {

    @AuraEnabled
    public static void serverEcho() {
        System.debug('hello');
        Id p = [select id from profile where name='Customer Community User'].id;

        Account ac = new Account(name ='Grazitti132') ;
        insert ac;

        Contact con = new Contact(LastName ='testCon111222333',AccountId = ac.Id);
        insert con;

        User user = new User(alias = 'te4356', email='test123223@noemail.com',
                emailencodingkey='UTF-8', lastname='Testing312', languagelocalekey='en_US',
                localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                ContactId = con.Id,
                timezonesidkey='America/Los_Angeles', username='tes3er123@noemail.com');

        insert user;
//        system.runAs(user) {
//            // statements to be executed by this test user.
//        }
    }
}