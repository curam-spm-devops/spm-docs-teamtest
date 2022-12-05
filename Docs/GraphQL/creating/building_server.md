# Building your model changes for a facade

When you make model changes, you need to run different build targets if you create a new facade to be used by your GraphQL API. If you reuse existing facades, you can skip this section.

## About this task

Ensure that your local development environment is built as normal and your application can run successfully.

### Modeled new facades and structs

The following list outlines the step to perform if you modeled a new facade class or operation in Rational Software Architect:

1. From `EJBServer`, run `build generated` to generate the code from the model. The step does not compile handcrafted code.
2. Create the implementation for your modeled facade operations.
3. Run `build compile.implemented`.
4. Run `build database` to insert the security identifiers that are associated with the facade operations into the database.

The following list outlines the steps to perform if you added or modified structs:

1. From `EJBServer`, run `build generated` to rebuild the server.
2. From `webclient`, run `build client` to rebuild the client, to regenerate the jars that contain the struct or structs.
3. From `EJBServer`, run `build rest` to rebuild the REST application and to copy the jars that contain the struct or structs.
