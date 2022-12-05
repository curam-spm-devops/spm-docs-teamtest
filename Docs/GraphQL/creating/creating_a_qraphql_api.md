# Developing a GraphQL API

Three artifacts are required to create a GraphQL API.

The following table lists the three artifacts that are involved when you create a GraphQL API.

Table 1. Artifacts that are involved when you create a GraphQL API

| Artifact | Description|
| :---------- | :---------- |
| A GraphQL schema file entry. | The file entry defines the GraphQL API and the data objects that it returns. |
| Data fetcher Java™ class or Java™ classes. | The Java™ class or Java™ classes are the implementation classes that are started when an API is queried. The data fetcher calls to a facade method in the server and handles the mapping of input parameters to input structs. |
| A runtime wiring configuration file entry. |The file entry links the GraphQL API schema entry to a data fetcher class or classes.|

## Performance testing for new GraphQL APIs

GraphQL can be used to improve API performance through increased efficiency, by retrieving data in a single query. However, GraphQL is a flexible specification, with several well-documented caveats and anti-patterns. For this reason, it is advised that to prevent issues in production, you run performance tests on any GraphQL APIs that you create.
