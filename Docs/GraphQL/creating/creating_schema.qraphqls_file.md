# Adding APIs to the GraphQL schema

You can create an entry in the GraphQL schema to define an API. To define APIs and responses in your GraphQL schema file, create a new schema file and then adding an API definition to a schema.

## Creating a schema file

For each server component, only one schema file is added. If you do not have a schema file in your custom component, the following steps list outline how to create a schema file:

1. Create a `schema.graphqls` file in your custom component under the directory

   `%CURAM_DIR%/EJBServer/components/<COMPONENT_NAME>/rest/graphql/config/schema.graphqls`

   where:
    - `%CURAM_DIR%` is the SPM installation directory, which by default is `C:\IBM\Curam\Development`
    - `<COMPONENT_NAME>` is the name of your custom component

2. Add a top-level entry that extends the `Query` type. The original `Query` type is already defined in a default schema. Duplicate entries are not permitted. However, the schema definition supports extensions of types.

## Adding API definitions to a schema

The following steps outline how to add an entry for a new API into the schema:

1. Add an entry to the `Query` definition extension section, where the name of the API, the input parameters, and a response object type are defined.
2. Add a type definition for the response object of the API, where each attribute is given a name and type. The following list outlines important details about the definition and attributes:
   - As the response of the API corresponds to a return struct from a facade method, all attribute names must exactly match to the struct attribute names.
   - The type that is defined for each attribute is either a scalar or another object type.
   - Custom types are defined for special handling of certain data types.
   - For more information about the available data types, see [Cúram data types and GraphQL scalars](graphql_data_types.md).
  
3. At build time, any schema files that exist in the EJBServer components are merged into a single schema file. Each schema file is validated for syntax and also to ensure the APIs and types are unique as no duplicate definitions are permitted.

## Example

The following example represents one of the APIs in the schema. All types are prefixed by DOM to show that the types represent objects from the Domain model.

The `readIntegratedCase` API returns a `DOMIntegratedCase` object that contains a set of fields, where the `benefits` field is defined as an array of `DOMBenefit` objects.

In this way, elements in the schema are connected in a graph and
the requester can explicitly specify the data that it wants to fetch.
Each field in the data object type definition is either a scalar or another object. For more information about the scalars to use,
see [Cúram data types and GraphQL scalars](graphql_data_types.md).

Directives are used to denote special handling for code items. For more information about the details of directives, see [GraphQL directives for code items and frequency patterns](graphql_directives.md).

```
extend type Query {
    readIntegratedCase(case_id: GQL_ID!): DOMIntegratedCase
}

type DOMIntegratedCase {
        id: GQL_ID
        reference: String
        effective_date: GQL_Date
        registration_date: GQL_Date
        status: CodeItem @code
        type: CodeItem @code
        benefits: [DOMBenefit]
}

type DOMBenefit {
        id: GQL_ID
        reference: String
        type: CodeItem @code
        product_name: CodeItem @code
        product_type: CodeItem @code
        status: CodeItem @code
        effective_date: GQL_Date
}
```
