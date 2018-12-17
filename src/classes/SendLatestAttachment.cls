public with sharing class SendLatestAttachment {
    private Id parentId;
    public String emailAddress { get; set; }
    public String emailSubject { get; set; }
    public String emailBody { get; set; }
    public List<Id> selectedAttachmentIds { get; set; }
    private List<Attachment> selectedAttachments = new List<Attachment>();
    private Map<Id, Attachment> idToAttachment = new Map<Id, Attachment>();

    public List<SelectOption> getAttachments() {
        List<SelectOption> options = new List<SelectOption>();
        system.debug(idToAttachment);
        for (Id attId : idToAttachment.keySet()) {
            options.add(new SelectOption(attId, idToAttachment.get(attId).Name));
        }
        return options;
    }
        
    public SendLatestAttachment() {
        
        this.parentId = ApexPages.currentPAge().getParameters().get('id');
        this.idToAttachment = getIdToAttachmentMap();
        system.debug(this.idToAttachment);
        system.debug(parentId);
        List<Contact> allDetails = [SELECT Email FROM Contact WHERE id=: parentId];
//        String[] emailAddress = new String[]{};
        for(Contact curRec : allDetails){

            emailAddress= ((emailAddress == null) ? '': emailAddress+ ',')  + curRec.Email;
        }
        System.debug(emailAddress);
    }
    
    private Map<Id, Attachment> getIdToAttachmentMap() {
        Map<Id, Attachment> idToAttachment = new Map<Id, Attachment>(
        [
                SELECT Id
                        , Name
                        , Body
                        , ContentType
                FROM Attachment
                WHERE Parentid = :parentId
                ORDER BY LastModifiedDate DESC
        ]);
        
        return idToAttachment; 
    }
    
    private Messaging.EmailFileAttachment createNewEmailFileAttachment(Attachment att) {
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName(att.Name);
        efa.setBody(att.Body);
        efa.setContentType(att.ContentType);
        return efa;
    }
    
    public PageReference doSend() {
//        String emailString = ApexPages.currentPAge().getParameters().get('email');
        for (Id selectedAttachmentId : selectedAttachmentIds) {
            selectedAttachments.add(idToAttachment.get(selectedAttachmentId));
        }

        try {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[]{
                    emailAddress
            };
            System.debug('Email=' + emailAddress);
            email.setToAddresses(toAddresses);
            email.setSubject(emailSubject);
            email.setHtmlBody(emailBody);

            List<Messaging.EmailFileAttachment> emailAttachments = new List<Messaging.EmailFileAttachment>();
//        for(Attachment att : attachments) {
            for (Attachment selectedAttachment : selectedAttachments) {
                emailAttachments.add(createNewEmailFileAttachment(selectedAttachment));
            }
           
//        }

            email.setFileAttachments(emailAttachments);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{
                    email
            });
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
        return new PageReference('/' + parentId);
    }

    public PageReference doReturn() {
        return new PageReference('/' + parentId);
    }
}