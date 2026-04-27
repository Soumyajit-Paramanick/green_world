#!/bin/bash

echo "🧹 Cleaning old setup..."
docker rm -f jenkins-ubuntu 2>/dev/null

echo "🚀 Pulling Ubuntu image..."
docker pull ubuntu:22.04

echo "🐳 Running container (Jenkins + Nginx ports)..."
docker run -d -p 8080:8080 -p 80:80 --name jenkins-ubuntu ubuntu:22.04 sleep infinity

echo "📦 Installing dependencies inside container..."
docker exec jenkins-ubuntu bash -c "
apt update &&
apt install -y openjdk-21-jdk curl git nginx &&
mkdir -p /opt &&
curl -L https://get.jenkins.io/war-stable/latest/jenkins.war -o /opt/jenkins.war
"

echo "🌐 Starting Nginx..."
docker exec jenkins-ubuntu service nginx start

echo "🚀 Starting Jenkins..."
docker exec -d jenkins-ubuntu bash -c "java -jar /opt/jenkins.war"

echo "⏳ Waiting for Jenkins to initialize..."

# Wait until password file exists
until docker exec jenkins-ubuntu test -f /root/.jenkins/secrets/initialAdminPassword
do
  sleep 2
  echo "⌛ Waiting..."
done

echo ""
echo "🔑 Jenkins Initial Admin Password:"
docker exec jenkins-ubuntu cat /root/.jenkins/secrets/initialAdminPassword

echo ""
echo "🌐 Jenkins URL: http://localhost:8080"
echo "🌐 Website URL: http://localhost"
