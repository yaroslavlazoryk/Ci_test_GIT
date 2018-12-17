/**
 * Created by new on 07.07.2017.
 */

public with sharing class pageToDeleteController {
    public List<AccountWithCheckBox> accsWithCheckBoxes{get;set;}
    List<Account> accs{get;set;}
    List<Account> toDelete{get;set;}
    List<Account> toSave{get;set;}
    public List<AccountWithCheckBox> getAccountWithCheckBoxes(){
        accs = [SELECT Name From Account];
        accsWithCheckBoxes = new List<AccountWithCheckBox>();
        for (Account acc : accs){
            accsWithCheckBoxes.add(new AccountWithCheckBox(acc,false));
        }
        System.debug(accsWithCheckBoxes);
        return accsWithCheckBoxes;
      //  upsert accs;
    }
    public void deleteChecked(){
        toDelete = new List<Account>();
        toSave = new List<Account>();
        for (AccountWithCheckBox accWithCB :accsWithCheckBoxes){
            if (accWithCB.del){
                toDelete.add(accWithCB.acc);
            }else{

            }

        }
        System.debug(toDelete);
        if(!toDelete.isEmpty()){
            delete toDelete;
        }
    }
}