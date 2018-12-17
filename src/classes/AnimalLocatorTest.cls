/**
 * Created by new on 04.07.2017.
 */

@IsTest
private class AnimalLocatorTest {
    static testMethod void testBehavior() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        //String result = '';
        String result = AnimalLocator.getAnimalNameById(2);

        System.assertEquals('scary bear',result, 'The animals are same.');
       // System.assertEquals('gg',AnimalLocator.getAnimalNameById(100));
    }
    static testMethod void testNULL() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        //String result = '';
        String result = AnimalLocator.getAnimalNameById(100);

        System.assertEquals('gg',result);
       // System.assertEquals('gg',AnimalLocator.getAnimalNameById(100));
    }
}