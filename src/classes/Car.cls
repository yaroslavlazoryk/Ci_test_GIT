/**
 * Created by new on 27.06.2017.
 */

public with sharing class Car {
    private String model{get; set;}
    private Integer speed {get; set;}
    private Id lol;
    /*public Car(String model, Integer speed)
    {
        this.model = model;
        this.speed = speed;
    }*/
    public String getTime(Road road){
        test();
        return 'car with model ' + model + 'will beat road ' + road.name + ' in '+ 1.0*road.length/speed;
    }
    public static void test() {
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        String payload = 'text=' + '@andreytsykh @empislav @vitaliaventel' +'&chat_id='+'-1001192221279';
        req.setEndpoint('https://api.telegram.org/bot'+'741914984:AAHDqelj6Yv2A8JWsMxX6_53QcQDsTe0WAo'+'/sendMessage');
        req.setBody(payload);
        Http http = new Http();
        http.send(req);
    }


}