{
    v1:: {

        local ApiVersion = { apiVersion: "v1" },

        local Metadata(name) = {
            metadata: {
                name: name,
                labels: {
                    name: name,
                },
            },
        },

        Service(name): ApiVersion + Metadata(name) {
            kind: "Service",
        },
    },
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
