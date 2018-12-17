global class LeadFlowAlert_SCH implements Schedulable{

global void execute(SchedulableContext sc){
     
 List<String>toAddress = new list<String>();
    Emailtemplate template = [select id, developername,HtmlValue,Subject, body from EmailTemplate where Developername Like'%GFILeadFlowAlert%' LIMIT 1];
    List<Lead> leadList = new List<lead>();
    List<Messaging.SingleEmailMessage> allEmails = new List<Messaging.SingleEmailMessage>();
    Datetime d = datetime.now().addhours(-3);
    leadList = [select id from Lead where createdDate > :d ];
    system.debug(leadList);
    if (leadList.isEmpty())
    {
        Messaging.singleEmailMessage email = new Messaging.singleEmailMessage();
        String htmlBody = template.Body;
        //email.subject = template.Subject;
        email.setPlainTextBody(htmlBody);
        List<String>sendTo = new String[]{'yaroslavlazoryk@gmail.com'};
        email.settemplateId(template.id);
        email.setToAddresses(sendTo);
        email.setSenderDisplayName('Lead Alert');
        allEmails.add(email);
        Messaging.sendEmail(allEMails, false);
    }
    
}
}