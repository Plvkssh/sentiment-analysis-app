$mk = "C:\Program Files\Kubernetes\Minikube\minikube.exe"

& $mk status | Out-Null

& $mk image build -t sentiment-analysis:latest -f docker/Dockerfile .
