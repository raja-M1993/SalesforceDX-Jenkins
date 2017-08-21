<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>welcome_message</fullName>
        <field>Message__c</field>
        <formula>&quot;Welcome&quot; &amp; username__c</formula>
        <name>welcome message</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Username Welcome</fullName>
        <actions>
            <name>welcome_message</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>UserDetail__c.username__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
