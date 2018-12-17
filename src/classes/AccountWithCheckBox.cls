/**
 * Created by new on 07.07.2017.
 */

public with sharing class AccountWithCheckBox {
    public Account acc{get;set;}
    public Boolean del{get;set;}
    public AccountWithCheckBox(Account acc, Boolean del){
        this.acc = acc;
        this.del = del;
    }
}