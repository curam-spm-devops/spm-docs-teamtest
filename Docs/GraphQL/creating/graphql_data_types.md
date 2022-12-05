# Cúram data types and GraphQL scalars

An object type that is defined in a GraphQL schema consists of fields, where each field has a type that might be either a scalar or another object type itself. A scalar represents the lowest leaf of a query.

For more information, see [Scalars](https://www.graphql-java.com/documentation/v14/scalars/) and [Schemas and Types](https://graphql.org/learn/schema/).

## List of available GraphQL data types and scalars

GraphQL provides a number of built-in scalars. The GraphQL server in Social Program Management provides some additional scalars to handle the Cúram specific Java types. When a query is invoked and data is read from the server, the following list outlines how
the Java types are handled:

- The Java types are converted to their equivalent scalar.
- The scalars are serialized into JSON for the HTTP response.

It is important to define each field of an object in the schema with the correct scalar. The following table includes a list of the scalars to use for the corresponding Cúram and Java data types. The creation of new custom scalars is not supported.

Table 1. A list of the scalars to use for the corresponding Cúram and Java data types

| Cúram data type | GraphQL scalars | JSON type | Description
| :---------- | :---------- | :---------- |
| SVR_STRING | String | String | A UTF‐8 character sequence. |
| SVR_BOOLEAN | Boolean | Booelan | True or false. |
| SVR_INT8 | Byte | Number | a java.lang.Byte based scalar.|
| SVR_INT16 | Short | Number | a java.lang.Short based scalar.|
| SVR_INT32 | Int | Number | A signed 32‐bit integer. |
| SVR_INT64 | GQL_ID | String | A Cúram scalar for converting a java.lang.long to a string because a JSON number cannot hold a value as large as a long value. |
| SVR_FLOAT | Float | Number | A signed double-precision floating-point value. |
| SVR_DOUBLE | Float | Number | A signed double-precision floating-point value.  |
| SVR_DATE| GQL_Date | String, with the date in an ISO8601 format | A Cúram scalar for converting a Java `Date` to a Cúram `Date`. |
| SVR_DATETIME| GQL_DateTime | String, with the `datetime` in an ISO8601 format | A Cúram scalar for converting a Java `DateTime` to a Cúram `DateTime`. |
| SVR_MONEY | GQL_Money | Number | A Cúram scalar for Cúram Money to a double. |
