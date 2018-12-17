/**
 * Created by new on 22.02.2018.
 */

public with sharing class MyClass {
    public Integer nonstaticbro = 0;
    public static Integer staticbro = 2;

    public class RGB {

        Integer red;
        Integer green;
        Integer blue;
        public Integer bla = 5;

        public RGB(Integer red, Integer green, Integer blue) {
            this.red = red;
            this.green = green;
            this.blue = blue;
            System.debug(staticbro);
        }
    }

    static Map<String, RGB> colorMap = new Map<String, RGB>();

    static {
        colorMap.put('red', new RGB(255, 0, 0));
        colorMap.put('cyan', new RGB(0, 255, 255));
        colorMap.put('magenta', new RGB(255, 0, 255));
    }
    public void test() {
        RGB rrr = new RGB(1,2,3);
        rrr.bla = 123;
        System.debug(rrr.bla);

    }
}