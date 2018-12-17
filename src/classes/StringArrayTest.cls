public class StringArrayTest {
    public static List<String> generateStringArray(Integer count)
    {
        List<String> returnList = new List<String>();
        for(Integer i = 0; i < count; i++)
        {
            returnList.add('Test ' + i);
        }
        return returnList;
    }

}