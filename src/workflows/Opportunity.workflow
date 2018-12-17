<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Status_Not_Approved</fullName>
        <field>Discount_Percent_Status__c</field>
        <literalValue>Not Approved</literalValue>
        <name>Status Not Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>trte</fullName>
        <field>Name</field>
        <formula>TEXT(StageName)</formula>
        <name>trte</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>terst</fullName>
        <actions>
            <name>trte</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR( 
ISPICKVAL(StageName ,&quot;Closed Lost&quot;), 
ISPICKVAL(StageName ,&quot;Closed Won&quot;) 
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
