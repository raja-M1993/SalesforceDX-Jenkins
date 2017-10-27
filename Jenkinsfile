import groovy.json.JsonSlurperClassic
pipeline {
	environment 
	{
		
    def SFDC_USERNAME=''	
    def HUB_ORG=System.getenv("HUB_ORG_DHC")
    def SFDC_HOST=System.getenv("SFDC_HOST_DH")
    def JWT_KEY_CRED_ID=System.getenv("JWT_CRED_ID_DH")
	def emailRecipients=System.getenv("emailRecipients")
	def rmgsplit=''
    def CONNECTED_APP_CONSUMER_KEY=System.getenv("CONNECTED_APP_CONSUMER_KEY_DH")
		def toolbelt=tool('toolbelt')
  
	}
	agent any
    stages {
	stage('checkout source') {
        steps
		{
       checkout scm 
	 
	      }
	}
	stage('Authorize Scratch Org') {
		steps{
		withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')])
		{
		script
		{
           echo "started"  
          rc = sh returnStatus: true,script: "${toolbelt}/sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername"
           if (rc != 0) { error 'hub org authorization failed' }
			
rmsg = sh returnStdout: true, script: "${toolbelt}/sfdx force:org:create --definitionfile config/project-scratch-def.json --json --setdefaultusername"
         echo "results in rmg in values--------------------------->"+rmsg
		echo rmsg.getClass().getName()
		println rmsg.length()
		
		
			def rmsg1=rmsg.substring(rmsg.indexOf("{"))
			 
			def robj =new JsonSlurperClassic().parseText(rmsg1)
			print robj
			echo "status checking"			
            if (robj.status != 0) { error 'org creation failed: ' + robj.message }
			echo "assign values";
            SFDC_USERNAME=robj.result.username
			println SFDC_USERNAME
            robj = null
		
        }
		}
		}
		} 
		

    }
	

}

