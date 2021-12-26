local Kube = import "kube.libsonnet";

function(git_commit_hash = "staging", domain = "fallback.otbeaumont.me") [
    Kube.v1.Service("echoserver") {
        metadata+: {
            labels: {
                "app.kubernetes.io/name": "echoserver",
            },
            annotations: {
                "kubernetes.io/description": "Echo Server",
                "link.argocd.argoproj.io/external-link": "https://otbeaumont.me",
                "otbeaumont.me/test": domain,
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
                "otbeaumont.me/test": domain,
            },
        },
        spec: {
            replicas: 1,
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
                            image: "ghcr.io/oscartbeaumont-ext/k8s-argo-playground:" + git_commit_hash,
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
