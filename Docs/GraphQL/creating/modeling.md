# Modeling the GraphQL APIs

When you create a new GraphQL API, you must model a new facade in Rational Software Architect. You can also reuse an existing facade if a facade is available for the functionality that you want to expose by using GraphQL.

When you model the façade, ensure that the facade uses either the  `<<rest>>` or `<<facade>>` stereotype when modeling the facade as both can be called from a data fetcher.

**Note:** When you use the `<<facade>>` stereotype, you cannot model lists within lists as it causes errors when you build the model.
