/**
 * Created by new on 27.06.2017.
 */

public with sharing class ClassWithSamples {
    /*public void DoSmthing() {
        Car car = new Car();
        car.
        car.model = 'lambo';

        Motorcycle motorcycle = new Motorcycle();
        motorcycle.model = 'Subaru';

        Road road = new Road();
        road.name = 'doroga';
        road.length = 100;
        System.debug(car.getTime(road));
    }*/
    public void check() {
        Set<Road__c> roads = new Set<Road__c>([SELECT Id From Road__c]);
        Set<id> roadIds = new Set<Id>();
        for (Road__c road: roads){
            roadIds.add(road.Id);
        }
        List<Car__C> cars = [SELECT Id, Road__c,Model__c, Speed__c from Car__c where Road__c  in :roads];
        for (Road__c road : roads){
            //System.debug(road);
        }
        for (Car__c car : cars){
           // System.debug(car);
        }
        Road__c road = new Road__c(Name = 'road4',Name__c = 'road',Lenght__c = 135);
        Car__c car = new Car__c(Name = 'carforroad4',Model__c = 'ggg',Speed__c = 123, Road__c = road.Id);
        roads.add(road);
        roadIds.add(road.Id);
        Set<Id> updatedRoads1 = new Set<Id>();
        List<Id> needToUpdate = new List<Id>();
        for (Car__c car1 : cars){
          if (!updatedRoads1.contains(car1.Road__c)){
              updatedRoads1.add(car1.Road__c);
              if (car1.Model__C == 'gg'){
                  car1.Speed__c = 120;
                 // Lis
                 // needToUpdate.add(car1.Id);
              }
          }
        }
       // [select Speed__c from Car__c where id in :needToUpdate];
        update cars;
        Set<Car__C> cars2 = new Set<Car__C>([SELECT Id, Road__c,Model__c, Speed__c from Car__c]);
        for (Car__c car2 : cars2){
            System.debug(car2.Model__c + ' ' + car2.Speed__c);
        }
        //Set<>
        Map<Id, Set<Car__c>> pChilds =  new Map<Id, Set<Car__c>>();
        Set<Car__c> temp;
        for (Id roadId : roadIds) {
            temp = new Set<Car__c>([SELECT Id, Road__c,Model__c, Speed__c from Car__c where Road__c = :roadId]);
            pChilds.put(roadId, temp );
        }
        for (Id pId : pChilds.keySet() ){
            System.debug('parent ' + pId);
            for (Car__c carc : pChilds.get(pId)){
                System.debug('Child ' + carc.Id);
            }
        }
        System.debug('ct1 ' );
        for (Car__c ct : cars){
            System.debug('ct ' + ct.Id);
        }
        System.debug('ct 1' );
        for (Id pid : pChilds.keySet()){
            for (Car__c carqq : cars){

                //System.debug(carqq.Id + ')))');
                if (pChilds.get(pid).contains(carqq)){
                    System.debug(carqq.Id + '((((');
                }
            }
        }


    }
   // List<Road__C> roads = [SELECT Road__c from Car__c];
}