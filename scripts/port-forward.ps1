$mk = "C:\Program Files\Kubernetes\Minikube\minikube.exe"

Start-Process powershell -ArgumentList '-NoExit', '-Command', "& `"$mk`" kubectl -- -n monitoring port-forward svc/prometheus-grafana 3000:80"
Start-Process powershell -ArgumentList '-NoExit', '-Command', "& `"$mk`" kubectl -- -n monitoring port-forward svc/prometheus-kube-prometheus-prometheus 9090:9090"
Start-Process powershell -ArgumentList '-NoExit', '-Command', "& `"$mk`" kubectl -- port-forward svc/sentiment-analysis-service 8080:80"
