#!/bin/sh
echo $@
echo "start"
cd /home/ftmadmin
mkdir agent
cd agent

AGENTURL="https://vstsagentpackage.azureedge.net/agent/2.209.0/vsts-agent-linux-x64-2.209.0.tar.gz"
echo "Release "${AGENTRELEASE}" appears to be latest" 
echo "Downloading..."
wget -O agent.tar.gz ${AGENTURL} 
tar zxvf agent.tar.gz
chmod -R 777 .
echo "extracted"
./bin/installdependencies.sh
echo "dependencies installed"
sudo -u tfmadmin ./config.sh --unattended --url $1 --auth pat --token $2 --pool $3 --agent $4 --acceptTeeEula --work ./_work --runAsService
echo "configuration done"
./svc.sh install
echo "service installed"
./svc.sh start
echo "service started"
echo "config done"
exit 0
