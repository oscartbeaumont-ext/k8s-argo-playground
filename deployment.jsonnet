local Kube = import "kube.libsonnet";

function(some_value = "Hello World!") [
    Kube.v1.Service("echoserver") {
        metadata+: {
            labels: {
                "app.kubernetes.io/name": "echoserver",
            },
            annotations: {
                "kubernetes.io/description": "Echo Server",
                "link.argocd.argoproj.io/external-link": "https://otbeaumont.me",
                "otbeaumont.me/test": some_value,
            },
        },
        spec: {
            selector: {
                "app.kubernetes.io/name": "echoserver",
            },
            ports: [
                {
                    protocol: "TCP",
                    port: 80,
                    targetPort: 8080,
                },
            ],
        },
        
    },
    Kube.appsv1.Deployment("echoserver") {
        metadata+: {
            labels: {
                "app.kubernetes.io/name": "echoserver",
            },
            annotations: {
                "kubernetes.io/description": "Echo Server",
                "link.argocd.argoproj.io/external-link": "https://otbeaumont.me",
                "otbeaumont.me/test": some_value,
            },
        },
        spec: {
            replicas: 5,
            selector: {
                matchLabels: {
                    "app.kubernetes.io/name": "echoserver",
                },
            },
            template: {
                metadata: {
                    labels: {
                        "app.kubernetes.io/name": "echoserver",
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
    },
]
