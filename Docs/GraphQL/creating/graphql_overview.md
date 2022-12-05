# GraphQL terms

Ensure that you understand the key terms that are associated with GraphQL.

The following table lists the common GraphQL terms that are used throughout the GraphQL documentation.
Table 1. Common GraphQL terminology

| GraphQL Term | Description |
| :---------- | :---------- |
| Query | The equivalent of a `read` or `GET` operation, where data is read and returned from the server. |
| Mutation | The equivalent of a `create`, `update`, `delete` or `POST`, `PUT` or `DELETE` operation, where data is modified on the server. Mutations are not supported by the GraphQL infrastructure. |
| Schema | A schema is used to define data objects and the APIs that are the entry points to the objects. The schema permits validations of queries. The schema also permits your GraphQL APIs to be discovered and is analogous to a Swagger specification for REST APIs.|
| Data fetcher | The GraphQL schema is linked to an underlying SPM facade operation by a Java™ class that is called a data fetcher. Data fetchers are also known as resolvers and third-party libraries. Data fetchers is a class that is started when a query runs and identifies how to retrieve or update data on the server, usually by calling to a facade operation in the EJB server. |
| Runtime wiring| The runtime wiring defines the data fetcher to use when an API that is defined in the schema is started at run time. You can also use the runtime wiring to specify different data fetchers for individual attributes of an object.|
| GraphQL endpoint |All queries and mutations use the same endpoint, that is, POST `https://<server>:<port>/Rest/graphql`. The details of the API or APIs to query and the attributes of the APIs to include in the response are all sent in the request body. |

**Note:** By default, the GraphQL endpoint is disabled as GraphQL is a new feature and not yet widely used in Social Program Management. As a result, the GraphQL APIs in the product can’t be accessed until the system property that controls the endpoint is enabled.
For more information,
see [Configuring GraphQL properties](setting_system_properties.md).
