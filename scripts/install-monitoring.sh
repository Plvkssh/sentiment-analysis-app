#!/bin/bash

echo "=== Установка системы мониторинга ==="

# Добавление репозиториев Helm
echo "Добавление репозиториев Helm..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

# Создание namespace для мониторинга
echo "Создание namespace для мониторинга..."
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -

# Установка Prometheus и Grafana
echo "Установка Prometheus и Grafana..."
helm install prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --set grafana.adminPassword=admin \
  --set prometheus.prometheusSpec.retention=30d \
  --set prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec.resources.requests.storage=10Gi

# Ожидание установки
echo "Ожидание установки компонентов мониторинга..."
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=grafana -n monitoring --timeout=300s
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=prometheus -n monitoring --timeout=300s

# Получение информации о сервисах
echo "=== Сервисы мониторинга ==="
kubectl get svc -n monitoring

# Настройка port-forward для доступа к Grafana
echo "Для доступа к Grafana выполните:"
echo "kubectl port-forward svc/prometheus-grafana 3000:80 -n monitoring"
echo "Логин: admin, Пароль: admin"

echo "Мониторинг установлен успешно!"