///**
// * Created by new on 03.08.2017.
// */
//
//public with sharing class ZhenaTaskPageController {
//    public String message {get;set;}
//    public void getNewMessage(){
//        this.message = 'helloMan';
//    }
//    public PageReference methodOne() {
//
//        return null;
//    }
//
//}
/*** Controller ***/
public class ZhenaTaskController {
    String uname;

    public String getUsername() {
        return uname;
    }

    public PageReference sayHello() {
        uname = UserInfo.getName();
        return null;
    }

    public void setState(String n) {
        state = n;
    }

    public String getState() {
        return state;
    }

    public PageReference methodOne() {
        return null;
    }

    private String state = 'no';
}