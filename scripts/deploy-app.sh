#!/bin/bash

echo "=== Сборка и развертывание приложения ==="

# Переход в директорию проекта
cd /mnt/okcomputer/output/sentiment-analysis-app

# Сборка Java приложения
echo "Сборка Java приложения..."
mvn clean package -DskipTests

# Сборка Docker образа
echo "Сборка Docker образа..."
docker build -t sentiment-analysis:latest -f docker/Dockerfile .

# Загрузка образа в Minikube
echo "Загрузка образа в Minikube..."
minikube image load sentiment-analysis:latest

# Применение Kubernetes манифестов
echo "Применение Kubernetes манифестов..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml
kubectl apply -f k8s/hpa.yaml

# Ожидание развертывания
echo "Ожидание развертывания..."
kubectl rollout status deployment/sentiment-analysis --timeout=300s

# Проверка статуса подов
echo "=== Статус подов ==="
kubectl get pods -l app=sentiment-analysis

# Проверка сервисов
echo "=== Статус сервисов ==="
kubectl get svc

# Проверка ingress
echo "=== Статус ingress ==="
kubectl get ingress

# Проверка HPA
echo "=== Статус HPA ==="
kubectl get hpa

echo "Приложение развернуто успешно!"