#!/bin/bash

echo "=== Тестирование приложения ==="

# Получение IP Minikube
MINIKUBE_IP=$(minikube ip)
echo "Minikube IP: $MINIKUBE_IP"

# Получение URL сервиса
SERVICE_URL=$(minikube service sentiment-analysis-service --url)
echo "Service URL: $SERVICE_URL"

# Тестирование эндпоинта анализа тональности
echo "=== Тестирование эндпоинта анализа тональности ==="

# Тест 1: Положительный текст
echo "Тест 1: Положительный текст"
curl -X GET "$SERVICE_URL/api/sentiment?text=This%20is%20a%20great%20day!" | jq .

# Тест 2: Негативный текст
echo "Тест 2: Негативный текст"
curl -X GET "$SERVICE_URL/api/sentiment?text=I%20feel%20terrible%20and%20sad" | jq .

# Тест 3: Текст на русском
echo "Тест 3: Текст на русском"
curl -X GET "$SERVICE_URL/api/sentiment?text=Это%20прекрасный%20день!" | jq .

# Тест 4: Нейтральный текст
echo "Тест 4: Нейтральный текст"
curl -X GET "$SERVICE_URL/api/sentiment?text=The%20weather%20is%20cloudy" | jq .

# Тестирование health check
echo "=== Тестирование health check ==="
curl -X GET "$SERVICE_URL/actuator/health" | jq .

# Тестирование метрик
echo "=== Тестирование метрик ==="
curl -X GET "$SERVICE_URL/actuator/prometheus" | grep sentiment_api_duration_seconds_count

# Нагрузочное тестирование
echo "=== Нагрузочное тестирование ==="
echo "Запуск 100 запросов с параллелизмом 10..."
for i in {1..100}; do
    curl -s "$SERVICE_URL/api/sentiment?text=test%20message%20$i" > /dev/null &
done
wait
echo "Нагрузочное тестирование завершено!"

# Проверка логов подов
echo "=== Логи подов ==="
kubectl logs -l app=sentiment-analysis --tail=50

echo "Тестирование завершено!"