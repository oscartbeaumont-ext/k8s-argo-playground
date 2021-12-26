{
    appsv1:: {

        local ApiVersion = { apiVersion: "apps/v1" },

        local Metadata(name) = {
            metadata: {
                name: name,
                labels: {
                    name: name,
                },
            },
        },

        Deployment(name): ApiVersion + Metadata(name) {
            kind: "Deployment",
        },
    },
}
