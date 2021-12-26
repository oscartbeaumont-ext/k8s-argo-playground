local Kube = import "kube.libsonnet";

{
    some_value:: "Hello World!",

    "echoserver.yaml": Kube.v1.Deployment("echoserver") {
        metadata+: {
            name: "echoserver",
            labels: {
                app: "echoserver",
            },
            annotations: {
                "kubernetes.io/description": "Echo Server",
                "link.argocd.argoproj.io/external-link": "https://otbeaumont.me"
            },
        },
        spec: {
            replicas: 5,
            template: {
                metadata: {
                    labels: {
                        name: "echoserver",
                    },
                },
                spec: {
                    containers: [
                        {
                            name: "echoserver",
                            image: "k8s.gcr.io/echoserver:1.4",
                            ports: [
                                {
                                    containerPort: 8080,
                                },
                            ],
                        },
                    ],
                },
            },
        },
    }
}
