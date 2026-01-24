#!/bin/bash

echo "=== Запуск кластера Minikube ==="

# Запуск кластера с указанными параметрами
echo "Запуск кластера Minikube с 4 CPU, 8GB RAM, 2 узлами..."
minikube start --cpus=4 --memory=8192mb --nodes=2

# Проверка статуса кластера
echo "=== Статус кластера ==="
minikube status

# Включение аддонов
echo "=== Включение аддонов ==="
minikube addons enable metrics-server
minikube addons enable ingress

# Проверка доступных аддонов
echo "=== Доступные аддоны ==="
minikube addons list

# Получение информации о нодах
echo "=== Информация о нодах ==="
kubectl get nodes

# Получение информации о namespace
echo "=== Namespace ==="
kubectl get namespaces

echo "Кластер Minikube готов к работе!"