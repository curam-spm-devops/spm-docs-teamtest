# Building and deploying GraphQL APIs on Tomcat

Use specific Ant targets to build and deploy the GraphQL server on Tomcat.

## About this task

The GraphQL server is built into the REST application and includes the GraphQL APIs and other GraphQL artifacts. You must build the full REST application at least one time. You can use a separate GraphQL build target to update the GraphQL artifacts only,
without the need to rebuild the full REST application.

## Procedure

The following steps outline how to build the full REST application at development time:

1. Set your `$CATALINA_HOME` environment variable to the location of your Tomcat installation directory, for example `export CATALINA_HOME=%DEV_ENV_HOME%/tomcat`.
**Note:** If you do not set your `$CATALINA_HOME` environment variable to the location of your Tomcat installation directory, the REST build target finishes successfully. However, a warning message is displayed in the console that indicates the variable was not
set. As a result, nothing is built.
1. From `EJBServer`, run `build rest`. The step builds the REST development application in the `%CURAM_DIR%/EJBServer/build/RestProject/DevApp` directory. The following list outlines the step that are performed in addition to building the REST APIs:

   - It merges any schema files from the server components that match the directory structure `/EJBServer/components/<COMPONENT_NAME>/rest/graphql/config/schema.graphqls`.
   - It merges any runtime wiring files from the server components that match the directory structure `/EJBServer/components/<COMPONENT_NAME>/rest/graphql/config/runtime_wiring.yaml`. If duplicate entries are found in different files, the entries in the file
  with the higher server component order takes precedence.
   - It compiles any data fetcher java classes from the server components are found in the directory pattern `%CURAM_DIR%/EJBServer/components/<COMPONENT_NAME>/source/curam/<PACKAGE_NAME>/graphql/datafetcher/<class_name>.java`.

### Changing GraphQL artifacts

If you change any of the GraphQL artifacts only, that is, a data fetcher class, a schema entry, or a runtime wiring entry, then from `EJBServer`, run `build graphql`. Running that build target updates the GraphQL artifacts only in the built REST application.
