# Building the GraphQL APIs

After you implement your GraphQL APIs, you must build and deploy the GraphQL APIs to a running application.

The following list provides a summary of the steps that are required to build and deploy the GraphQL APIs to a running application:

1. Build the model changes, if facades or structs are added.
2. Build and deploy the REST application. The REST application includes the GraphQL server and the GraphQL APIs. Different build targets exist for building and deploying to Tomcat and to an application server.
3. Enable the GraphQL endpoint by using the `curam.graphql.endpoint.enabled` system property. For more information, see [Configuring GraphQL properties](../creating/setting_system_properties.md).
