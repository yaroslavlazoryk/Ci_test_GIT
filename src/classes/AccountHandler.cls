/**
 * Created by new on 21.06.2017.
 */

public with sharing class AccountHandler {
    public static Account insertNewAccount(String paramString) {
        try {
            Account newAccount = new Account(Name = paramString);
            insert newAccount;
            return newAccount;
        }
        catch (DmlException e)
        {
            return null;
        }

    }


}