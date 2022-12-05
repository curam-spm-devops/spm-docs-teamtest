# Example of customizing the data source for a GraphQL API

The following example shows how to customize the data source for an API and some API data object types that are defined in a schema.

The schema sample defines a `readIntegratedCase` API, that takes a `case_id` input parameter and returns an object of type `DOMIntegratedCase`.
The sample shows that the `DOMIntegratedCase` type contains a set of fields where one field is linked to an array of `DOMBenefit` objects.

The following list outlines some field types:

- `GQL_ID` represents a unique identifier. `GQL_ID` is used for all IDs.
- `GQL_Date` represents a Cúram date type.
- `CodeItem` is used to define an object that represents a code item.
- `@code` is a directive, that indicates to the underlying server that a single Java attribute that contains a code value must be converted to a `CodeItem` object.

For information about the full list of scalars to use for each data type, see [Cúram data types and GraphQL scalars](../creating/graphql_data_types.md).

The following code outlines the schema definition:

```
type Query {
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

type CodeItem {
        code: String
        description: String
        tableName: String
}
```

The following code shows the corresponding existing entry in the `runtime_wiring.yaml` file, that defines the two data fetcher classes to use for the `readIntegratedCase` API:

```
Query:
  - name: readIntegratedCase
    data_fetcher: curam.core.graphql.datafetcher.IntegratedCaseDataFetcher
FieldLevelWiring:
  - object_type: DOMIntegratedCase
    field:  benefits
    data_fetcher: curam.core.graphql.datafetcher.BenefitListDataFetcher
```

## Customizing the data source

Two custom data fetcher classes are created, for example, `curam.custom.graphql.datafetcher.CustomIntegratedCaseDataFetcher` and `curam.custom.graphql.datafetcher.CustomBenefitListDataFetcher`.
The classes reference custom facades. However, they must return the same object types as the existing data fetcher classes, that is `DOMIntegratedCase` and `List<DOMBenefit>`. The object types also match the object type definitions in the schema.

For more information, see [Creating a data fetcher class](../creating/creating_data_fetcher_file.md).

In a `runtime_wiring.yaml` file that is located in an EJBServer custom component, an entry is created that references the two new custom data fetcher classes. The following code shows the entry in the `runtime_wiring.yaml` file:

```
Query:
  - name: readIntegratedCase
    data_fetcher: curam.custom.graphql.datafetcher.CustomIntegratedCaseDataFetcher
FieldLevelWiring:
  - object_type: DOMIntegratedCase
    field:  benefits
    data_fetcher: curam.custom.graphql.datafetcher.CustomBenefitListDataFetcher
```

For more information, see [Configuring the runtime wiring for APIs](../creating/creating_runtime_wiring_file.md).

At build time, because the custom component is listed higher in the `SERVER_COMPONENT_ORDER` variable, the entries that are in the custom component `runtime_wiring.yaml` file will overwrite the entries that are in the original component.
