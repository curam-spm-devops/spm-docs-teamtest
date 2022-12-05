# ![This section applies from version 8.0.1](spm_8010.png) GraphQL

GraphQL is a query language for APIs.

Clients build queries for the data that clients need based on an underlying schema. The schema consists of a set of entities that are linked based
on the business relationships between them so that the entities form a graph. APIs are also defined in the schema and represent an entry point to the graph.

The system means that a client can request only the data that the client wants. It also means that the client can combine what might be defined
as multiple GraphQL APIs in the server into a single GraphQL query. As a result, significantly less network traffic passes between the client
and the backend server.

In IBM Cúram Social Program Management, a GraphQL API consists of a schema definition and an implementation class, called a data fetcher. The data fetcher wraps a
facade operation from the server. A GraphQL query can be made over the Hypertext Transfer Protocol (HTTP), by using the GraphQL query language,
to query one or more GraphQL APIs. The response is returned in a JSON format.

The GraphQL infrastructure is built into the REST application and is deployed as part of the REST ear.
