# Hello-Santhosh

Welcome to this tutorial designed to demystify the journey of an application from code on your local machine to a fully deployed containerized application within a Kubernetes cluster. Whether you're new to this world or seeking a simplified perspective, this guide aims to equip you with the fundamental concepts necessary to navigate the realm of container orchestration.

I've crafted this demo to illustrate the progression of an application's life cycle in its simplest form. Often, it's easy to enter an environment where everything is preconfigured, but grappling with abstract concepts can be daunting. Through this tutorial, I hope to convey the essence of transforming code into a deployable container and orchestrating it within a cluster to leverage its resources.

The approach here is deliberately generic, focusing on the core concepts of containerization and Kubernetes deployment. While the code, builds, and charts are streamlined for clarity, I encourage you to delve deeper, explore documentation, and experiment with configurations. Consider this tutorial as a springboard, igniting your curiosity to explore the vast possibilities that lie ahead.

Let's start from scratch with a Golang application. Whether it's a microservice, a personal project, or a utility tool, let your imagination guide you. Once we have our "application" — and I use that term loosely to encompass a broad range of possibilities — we'll proceed to host and standardize the deployment process, leveraging our familiarity with the application's architecture.

With a functional container, we possess a deployable entity capable of running wherever its image is deployed. Our next step is to introduce Kubernetes into the mix. Keeping it simple, we'll deploy the most minimal Helm chart to get our container up and running. The goal is to grasp the fundamental deployment concepts and inspire further exploration into Helm charts and Kubernetes resources.

This tutorial is tailored for intermediate-level SREs who are beginning to grasp these concepts. Let's embark on this journey together, empowering ourselves with the knowledge and skills to navigate the intricate landscape of container orchestration.

Shall we begin?

## Golang 

[Golang](https://go.dev/) stands out as a versatile, low-level programming language widely employed in modern-day applications. Engineers turn to Golang to tackle challenges that lack readily available solutions online or on platforms like GitHub.

To begin your journey with Golang, start by installing it. You can find installation instructions. [https://golang.org/doc/install]()

Once installed, create a directory for your project:

```shell
mkdir hello-santhosh
cd hello-santhosh
```

Within this directory, create a file named `main.go` where you'll craft your code:
```shell
touch main.go
```

Now, let's add the following code to `main.go`:

```go
package main

import (
    "fmt"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hello World!")
}

func main() {
    http.HandleFunc("/", handler)
    fmt.Println("Server listening on port 8080...")
    http.ListenAndServe(":8080", nil)
}
```
### Building Your Application

We'll create a module for our Golang application. This step is crucial, especially for more complex applications with dependencies, as it ensures that dependencies are appropriately compiled into the application.

Initialize the module with:

```shell
go mod init hello-santhosh
```
This command generates a go.mod file, capturing your project's dependencies.

Golang's nature as a compiled language offers speed advantages during runtime. However, building complex applications may entail longer build times, and debugging errors can occasionally prove challenging.

Compile your application using:

```shell
go build -o hello-santhosh
```
The `-o` flag specifies the output file, generating a binary named `hello-santhosh`. This binary contains the compiled machine code of your Golang application defined in `main.go`.

### Running Your Application

Execute your compiled binary with:

```shell
./hello-santhosh

```
You'll see the message:

```
Server listening on port 8080...
```

Now, open your browser and navigate to `http://localhost:8080` to see your application in action

## Dockerizing Your Application

Begin by creating a `Dockerfile`. This file will utilize the official Golang image for Alpine as a build image, providing a minimalistic OS tailored specifically for building Golang applications.

Before proceeding with building the container, ensure you have the go.mod file. You have several options to obtain this:

* Run go mod init hello-santhosh.
* Copy go.mod from 00golang into 01docker.
* Add RUN go mod init hello-santhosh to the Dockerfile just before the go build command.

### Building the Container

In `00golang`, we successfully built a Golang application and executed it in our shell. However, for applications meant to serve more than your laptop, hosting them in a Docker container offers numerous advantages. This step abstracts the building and running process while providing the flexibility to modify application values, such as input variables.

As a challenge, consider modifying your Golang application to accept the server port as an environment variable. Docker facilitates this by allowing the provision of environment variables as inputs.

For now, let's focus on building a container image using our Dockerfile:

```shell
Docker build . -t hello-santhosh:0.0.1 -t hello-santhosh:latest -t mdpierce/hello-santhosh:0.0.1
```

To prepare for the Kubernetes section later, I'll push this image to my Docker Hub. If you're logged in with Docker Desktop or have an account, you can follow along by replacing my username with yours:

```shell
docker push mdpierce/hello-santhosh:0.0.1
```

### Running the Container

To run your container, built using the `Dockerfile` and exposing port `8080`, execute the following command:

```shell
docker run -p 8080:8080 hello-santhosh:0.0.1
```
Alternatively, you can run it using the latest tag we provided:

```shell
docker run -p 8080:8080 hello-santhosh:latest
```

By now, you should understand that with each code build, the semantic version changes, which can be integrated into your scripting, tooling, or actions for building Docker images based on application versions. Additionally, you grasp that input flags and values can be variables at different stages of the process.

## Kubernetes Deployment

If you're using Docker Desktop, I highly recommend enabling Kubernetes for a seamless experience. Follow these steps:

* Open Docker Desktop.
* Navigate to Settings (the cog icon in the top right).
* Under Kubernetes:
    * Enable Kubernetes.
    * Wait for the process to complete.

Once enabled, you should find an entry for docker-desktop in your kube config. Test this configuration by running:

```shell
`k9s --context docker-desktop`
```

### Helm Chart

In the `chart` directory. You'll discover the most minimal Helm chart ready to deploy your application.

### Deploying Your Application

Navigate to the `02kubernetes` directory and execute the following command to deploy your application:

```
helm install --kube-context docker-desktop hello-santhosh ./hello-santhosh/
```

Should you make any changes and wish to update the deployment, use the following command:


```shell
helm upgrade --kube-context docker-desktop -i hello-santhosh ./hello-santhosh/
```

At this stage, you should be able to port forward the pod using either k9s or kubectl and access it via http://localhost:8080.

Congratulations! You've successfully built and deployed an application locally, using Docker, and deployed to Kubernetes. Armed with these concepts, you're ready to embark on further exploration and refinement. Well done!

# Summary and Conclusion

In this tutorial, we embarked on a journey from crafting a Golang application to deploying it locally, within Docker, and finally within a Kubernetes cluster. Let's recap the key steps and concepts covered:

* **Golang Basics:** We explored the fundamentals of Golang, a powerful language utilized in modern-day applications. We set up a simple web server using Golang's native libraries.

* **Dockerization:** Leveraging Docker, we containerized our Golang application, encapsulating it with its dependencies into a portable, isolated unit. This process abstracted the building and running of our application, enabling seamless deployment across different environments.

* **Kubernetes Deployment:** With Kubernetes, we orchestrated the deployment of our containerized application within a cluster. Using Helm charts, we streamlined the deployment process, abstracting complexities and ensuring consistency across deployments.

By following these steps, you've gained insights into the entire application life cycle, from development to deployment:

* **Development:** Crafting your application logic with Golang, ensuring it meets your requirements.

* **Containerization:** Packaging your application and its dependencies into a Docker container, facilitating consistency and portability.

* **Orchestration:** Deploying your containerized application within a Kubernetes cluster, leveraging Helm charts for simplified management and scalability.

Through this tutorial, you've not only mastered the basic concepts of Golang, Docker, and Kubernetes but also gained practical experience in building and deploying applications in real-world scenarios.

Armed with this knowledge, you're well-equipped to explore and innovate further, leveraging these powerful tools to develop and deploy robust applications efficiently.
