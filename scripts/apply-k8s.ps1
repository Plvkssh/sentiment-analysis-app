$mk = "C:\Program Files\Kubernetes\Minikube\minikube.exe"

& $mk kubectl -- apply -f k8s/deployment.yaml
& $mk kubectl -- apply -f k8s/service.yaml
& $mk kubectl -- apply -f k8s/hpa.yaml

& $mk kubectl -- -n monitoring apply -f k8s/sentiment-servicemonitor.yaml
& $mk kubectl -- -n monitoring apply -f k8s/sentiment-prometheusrule.yaml
