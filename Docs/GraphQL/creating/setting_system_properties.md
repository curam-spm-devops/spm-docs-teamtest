# Configuring GraphQL properties

To use GraphQL, you must first enable the GraphQL endpoint by using a system property. You can use other system properties to control features in the GraphQL server.

Enable the properties in the `Application.prx` file for your custom component or use the Cúram administration console. If you change these properties in a running server, you might need to restart the server to update the property cache in the REST application.

The following table provides information about the GraphQL configuration properties.

Table 1. GraphQL configuration properties

| Property | Display name| Default value | Description |
| :---------- | :---------- | :---------- | :---------- |
| Enable GraphQL | `curam.graphql.endpoint.enabled` | `False` | A setting that defines whether the GraphQL endpoint URL is enabled or disabled. |
| Enable GraphQL introspection | `curam.graphql.introspection.enabled` | `False` | A setting that defines whether introspection queries are enabled or disabled. Introspection queries return details about the available GraphQL schema. The setting is required if you are using the GraphiQL HTML page to view the GraphQL schema or to test a GraphQL query for the APIs in a development environment. As the GraphiQL HTML page is not added to the REST ear, use the `False` default value where you are not supplying an integrated development environment (IDE) or other way to use introspection queries. In a production environment, set the property to `False`.|
| Maximum GraphQL schema query depth | `curam.graphql.max.schema.query.depth` | `20` | A setting that defines the maximum GraphQL schema query depth to prevent large queries that might potentially affect the performance of the server.|
| GraphQL schema complexity | `curam.graphql.schema.complexity` | `200` | Use the setting to define the complexity of a query because clients can query many APIs in one request. The setting defines the maximum complexity of a query that the server accepts. |

Because the GraphQL server is a part of the REST application, the configuration properties for REST apply to GraphQL, in addition to the properties that are listed in Table 1. The configuration properties are listed at [Cúram REST configuration properties](../MSDK/r_custom_rest_properties.html).

## Procedure

The following steps outline how to set the configuration properties:

1. Log in to Social Program Management as a system administrator.
2. Click **System Configurations** > **Shortcuts** > **Application Data** > **Property Administration**.
3. From the **Name** field, enter `GraphQL` and click **Search**.
4. Click the **...** icon for the property.
5. Select **Edit Value...** to update the value.
6. Click **Save**.
7. Click **Publish**.
