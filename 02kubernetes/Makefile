# We use a lot of Makefiles and this is a super generic one to start with.
.PHONY: deploy update

CTX := docker-desktop

deploy:
	helm install --kube-context $(CTX) hello-santhosh ./hello-santhosh/

upgrade:
	helm upgrade --kube-context $(CTX) -i hello-santhosh ./hello-santhosh/
