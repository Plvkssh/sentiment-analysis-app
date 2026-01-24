#!/bin/bash

echo "=== Установка Minikube ==="

# Установка Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Проверка установки
echo "Проверка версии Minikube:"
minikube version

# Установка kubectl
echo "=== Установка kubectl ==="
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Проверка установки kubectl
echo "Проверка версии kubectl:"
kubectl version --client

echo "=== Установка Helm ==="
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Проверка установки Helm
echo "Проверка версии Helm:"
helm version

echo "Установка завершена успешно!"