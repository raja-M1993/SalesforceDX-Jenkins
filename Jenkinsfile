#!groovy
import groovy.json.JsonSlurper
node {
     def SFDC_USERNAME
	def DEBUG_ISU=env.SFDX_DEBUG
    def HUB_ORG =env.HUB_ORG_DH
    def SFDC_HOST=env.SFDC_HOST_DH
    def JWT_KEY_CRED_ID=env.JWT_CRED_ID_DH

    def CONNECTED_APP_CONSUMER_KEY=env.CONNECTED_APP_CONSUMER_KEY_DH
    def toolbelt = tool 'toolbelt'
            println SFDC_HOST
            println JWT_KEY_CRED_ID
            println CONNECTED_APP_CONSUMER_KEY
            println HUB_ORG
			println toolbelt


    stage('checkout source') {
        // when running in multi-branch job, one must issue this command
        checkout scm
    }

    withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]) {
	
        stage('Authorize Scratch Org') {

           echo "started"
		   //echo debug_isu;
            rc = bat returnStatus: true,script: "\"${toolbelt}/sfdx\" force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername"
            if (rc != 0) { error 'hub org authorization failed' }
			}
			
			stage('Create Scratch Org')
			{
			  rmsg = bat returnStdout: true, script: "\"${toolbelt}/sfdx\" force:org:create -f config/project-scratch-def.json --json --setdefaultusername"
        printf rmsg
        def jsonSlurper = new JsonSlurper()
		@NonCPS
		
        def robj = jsonSlurper.parseText(rmsg)
        if (robj.status != "ok") { error 'org creation failed: ' + robj.message }
        SFDC_USERNAME=robj.username
        robj = null 
		
        }
		
	stage('Push To Test Org') {
            rc = bat returnStatus: true, script: "\"${toolbelt}/sfdx\" force:source:push --targetusername ${SFDC_USERNAME}"
            if (rc != 0) {
                error 'push failed'
            }
            
        }
        
    }
	
}
	
