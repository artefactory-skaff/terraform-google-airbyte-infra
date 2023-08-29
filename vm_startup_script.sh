#! /bin/bash

set -e

# Download and run the add-google-cloud-ops-agent-repo.sh script using curl and sudo bash
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
sudo bash add-google-cloud-ops-agent-repo.sh --also-install

# Install required packages
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add --
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian buster stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo apt-get -y install docker-compose-plugin

# Create the airbyte user and set up permissions
sudo useradd -m airbyte
sudo usermod -aG docker airbyte
cd /home/airbyte

# Uses Terraform's templatefile() to copy the contents of the airbyte_install folder to /home/airbyte
cat <<'EOT' >> .env
${env}
EOT

cat <<'EOT' >> flags.yml
${flags}
EOT

cat <<'EOT' >> docker-compose.yaml
${docker_compose}
EOT

sudo chown -R airbyte:airbyte /home/airbyte

# As the airbyte user, start the airbyte server using the startup script provided by airbytehq
sudo -i -u airbyte bash << EOF
wget https://raw.githubusercontent.com/airbytehq/airbyte/master/run-ab-platform.sh
chmod +x run-ab-platform.sh
./run-ab-platform.sh -b
EOF
