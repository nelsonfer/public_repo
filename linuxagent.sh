#!/bin/sh
echo $@
echo "start"
cd /home/tfmadmin
mkdir agent
cd agent

AGENTURL="https://vstsagentpackage.azureedge.net/agent/2.209.0/vsts-agent-linux-x64-2.209.0.tar.gz"
echo "Release "${AGENTRELEASE}" appears to be latest" 
echo "Downloading..."
wget -O agent.tar.gz ${AGENTURL} 
tar zxvf agent.tar.gz
chmod -R 777 .
echo "extracted"
sudo /home/tfmadmin/bin/installdependencies.sh
echo "dependencies installed"
sudo -u tfmadmin ./config.sh --unattended --url $1 --auth pat --token $2 --pool $3 --agent $4 --acceptTeeEula --work ./_work --runAsService
echo "configuration done"
sudo /home/tfmadmin/agent/svc.sh install
echo "service installed"
sudo /home/tfmadmin/agent/svc.sh start
echo "service started"
echo "config done"
exit 0
