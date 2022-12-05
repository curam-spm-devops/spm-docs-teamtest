# Customizing data sources for existing GraphQL APIs

A number of existing GraphQL APIs are available to use. Customizing existing APIs and type definitions in the schema is not supported.

However, you can customize how the data sources for APIs are retrieved. A GraphQL API defined in the schema is linked to an underlying Social Program Management facade by using a Java™ class that is called a data fetcher.
A runtime wiring configuration file contains the details of the data fetcher class or classes to use when a GraphQL API is called.

## Before you begin

You must have access to a Social Program Management development environment. You must build the REST application to create the final merged version of the GraphQL schema file.

You must understand the essential elements of GraphQL APIs and artifacts, that is, schema file, data fetchers, and runtime wiring, including how to create them.

The following list outlines the elements that you must understand before you customize GraphQL APIs and artifacts:

- [GraphQL](../creating/overview.md)
- [Creating a data fetcher class](../creating/creating_data_fetcher_file.md)
- [Configuring the runtime wiring for APIs](../creating/creating_runtime_wiring_file.md)
- [Modeling the GraphQL APIs](../creating/modeling.md)
- [Building the GraphQL APIs](../creating/building.md)

## Procedure

1. Identify the schema elements to customize. The following list outlines important considerations:

   - Identify the elements in the schema for which you intend to customize the data source. You can view the merged schema file directly in your development environment at
`/EJBServer/build/RestProject/DevApp/WEB-INF/classes/curam/graphql/schema.graphqls`.
  However, it is easier to view the details of the schema using the GraphiQL in-browser html page that is included in the REST application on Tomcat. For more information,
see [Viewing the GraphQL queries by using the GraphiQL IDE](../creating/viewing_graphql_query_using_introspection.md).
   - Look in the runtime wiring file to identify the data fetchers that are currently wired to the schema element. The runtime wiring file is located in your development environment at `/EJBServer/build/RestProject/DevApp/WEB-INF/classes/curam/graphql/runtime_wiring.yaml`.
   - An entry in the `Query` section of the `runtime_wiring.yaml` exists to specify the top-level data fetcher for the API.
   There might also be entries in the `FieldLevelWiring` section where specific attributes of the schema elements are wired to their own data fetcher.
   It is important to identify all current data fetchers wired to the API and then identify the data fetchers that you want to change.

1. Create a custom Social Program Management facade.
To customize the source of the data, you must create a custom Social Program Management facade in your own component. The new facade must match the same interface that the schema defines based on the existing facade.

    The input struct must contain attributes to match the request parameters. The output struct must be the same one as the one that is returned from the existing facade. The schema contains the name of the output struct that is being used because the name of
    the object type that is defined in the schema is also the name of the struct.

    The new custom facade can retrieve data from any part of the system if it complies with the same interface. Any `AppExceptions` that are produced by the facade are displayed directly in the application.

1. Create a custom data fetcher Java class to wrap the new Social Program Management facade so that it can be linked to from the schema. The data fetcher must parse the input from the GraphQL request and then map the input to structs so
that the facade can be called. For more information, see [Creating a data fetcher class](../creating/creating_data_fetcher_file.md).

1. Add an entry to the GraphQL runtime wiring configuration yaml file. The schema element is linked to the existing facade by the runtime wiring file. You must introduce your own version of this wiring file in your custom component. On a line-by-line basis,
the wiring overrides the matching wiring in the existing file.
For more information, see [Configuring the runtime wiring for APIs](../creating/creating_runtime_wiring_file.md).

1. Build the REST application, which includes the GraphQL artifacts.
