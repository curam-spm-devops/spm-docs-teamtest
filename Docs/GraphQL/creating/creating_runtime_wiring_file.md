# Configuring the runtime wiring for APIs

Runtime wiring is required to link an API that is defined in the schema to an implementation in a data fetcher class. The details are defined in a runtime wiring configuration file.

## About this task

 The method indicates to the server the data fetcher to start at run time when a query is received, as defined in the runtime wiring configuration file.

## Procedure

### Creating a new runtime wiring configuration file

Only one runtime wiring configuration file is added per server component.

Where you do not have a runtime wiring configuration file in your custom component, the following steps outline how to create one:

1. Create a new `runtime_wiring.yaml` file in your custom component in the location `%CURAM_DIR%/EJBServer/components/<COMPONENT_NAME>/rest/graphql/config/runtime_wiring.yaml`

   where:
    - `%CURAM_DIR%` is the Social Program Management installation directory, which by default is `C:\IBM\Curam\Development`
    - `<COMPONENT_NAME>` is the name of your custom component.

2. Add a top level `Query` section if none exists.

### Adding an entry to the runtime wiring configuration file

The following steps outline how to add an entry to the runtime wiring configuration file:

1. Add an entry to the `Query` section to define the data fetcher to be wired to the API. The following code provides an example:

   ```
   Query:
     - name: <the name of the API, as defined in the Query type in the schema>
       data_fetcher: <the fully qualified name of the data fetcher java class>
   ```

2. Optionally, further data fetchers can be wired to individual attributes within an API response object. Where none exists, add a top- level `FieldLevelWiring` section.

   Add an entry to the `FieldLevelWiring` section to define the data fetcher to be wired to a particular attribute in an object type defined in the schema. The following code provides an example:

   ```
   FieldLevelWiring:
     - object_type: <the name of object type, as defined in the schema>
       field:  <the name of the field within the object that the data fetcher applies to>
       data_fetcher: <the fully qualified name of the data fetcher java class>
   ```

3. At build time, the `runtime_wiring.yaml` files from all server components are merged into a single `runtime_wiring.yaml` file.
Where duplicate entries are found for queries or fields, the entry in the component with the higher server component order takes precedence. The method permits a different data fetcher to be wired to an existing API, although the data fetcher must match the
type definitions of the API in the schema.

## Example

In example 2 in the [Creating a data fetcher class](./creating_data_fetcher_file.md) page, the `readIntegratedCase` API is linked to the `IntegratedCaseDataFetcher`. A list of benefits is returned as part of the `DOMIntegratedCase` object and the `benefits` field is wired to its own data fetcher called `BenefitListDataFetcher`.

Generally, only fields that are linked to nested lists or objects have their own data fetchers. You can, however, also wire an individual field to its own data fetcher.

```
Query:
  - name: readIntegratedCase
    data_fetcher: curam.core.graphql.datafetcher.IntegratedCaseDataFetcher
FieldLevelWiring:
  - object_type: DOMIntegratedCase
    field:  benefits
    data_fetcher: curam.core.graphql.datafetcher.BenefitListDataFetcher
```

A further example of runtime wiring is in the `%CURAM_DIR%/EJBServer/components/core/rest/graphql/config/runtime_wiring.yaml` file.
