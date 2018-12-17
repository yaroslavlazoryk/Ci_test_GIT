/**
 * Created by new on 06.07.2017.
 */

public with sharing class EditSaveExtension {
    public Account acct{get;set;}
    public String accId{get;set;}
    public EditSaveExtension(ApexPages.StandardController stdController){
        acct = (Account)stdController.getRecord();
        System.debug(acct.Name);
    }
    public PageReference goToEditPage(){
        PageReference OpenNewPage = new PageReference('/apex/EditPage?id=' + acct.Id);
        OpenNewPage.setRedirect(true);
        //update acct;
        return OpenNewPage;
    }
    public PageReference goToSavePage(){
        PageReference OpenNewPage = new PageReference('/apex/SavePage?id=' + acct.Id);
        OpenNewPage.setRedirect(true);

        return OpenNewPage;
    }
    public PageReference goToEditPageSaveButton(){
        PageReference OpenNewPage = new PageReference('/apex/EditPage?id=' + acct.Id);
        OpenNewPage.setRedirect(true);
        update acct;
        return OpenNewPage;
    }
}