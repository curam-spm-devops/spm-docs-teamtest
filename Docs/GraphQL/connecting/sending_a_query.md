# Sending a GraphQL query from a client

The server has only a single GraphQL endpoint, which accepts a POST request. The GraphQL server is included as part of the REST application. The URL of the GraphQL endpoint is  `https://<server>:<port>/Rest/graphql`.

The details of the query, including the API or APIs to invoke and the attributes of the APIs that are requested, are added to the request body. The server then sends back a response that contains only the requested attributes.

The query is first parsed and validated by the GraphQL server to ensure all APIs and attributes that are specified match what is defined in the GraphQL schema, including any mandatory parameters, before any API is started.
