# Creating a data fetcher class

Each type in the schema is linked to a facade by a data fetcher Java class. The data fetcher class is a wrapper that performs any simple operations that are needed on the input parameters. The data fetcher then calls the facade.

One top-level data fetcher is mandatory for the query and is the implementation class that is started when the query is run.

You can also create extra separate data fetchers for the individual fields of a data object that is returned by an API. The method allows the data retrieval to be handled in the background by multiple facades. When a GraphQL API is queried, if the request does not include the field that uses a separate data fetcher, the corresponding facade is not invoked. As a result, less processing and fewer database reads might occur.
However, if all fields are included in the request, the data fetchers are invoked synchronously. If the API is designed with too many separate data fetchers,invoking the data fetchers synchronously might negatively affect performance.

## About this task

Each data fetcher class must implement a `graphql.schema.DataFetcher` interface. The `get()` method is the only one method that must be implemented. The following list outlines the tasks that the `get()` method must perform:

- Map the input parameters that are sent in the query to the input struct that the corresponding facade method must use.

- Call a utility method provided by the GraphQL server, passing it the name of the facade class and method that is to be called to retrieve the data and the populated input struct. In the background, this utility method calls the facade method in EJBServer.
and retrieves the response struct from the facade method.

- Return a Plain Old Java Object (POJO) that matches what is defined as the query response object in the schema. Typically, the POJO is the response struct from the facade method if the name of the struct matches exactly to the name of the data object that is
defined in the schema.

## Procedure

The following pattern outlines how to create a data fetcher class file in your custom component:

`%CURAM_DIR%/EJBServer/components/<COMPONENT_NAME>/source/curam/<PACKAGE_NAME>/graphql/datafetcher/<CLASS_NAME>.java`

where:

- %CURAM_DIR% is the Social Program Management installation directory, which by default is `C:\IBM\Curam\Development`
- `<COMPONENT_NAME>` is the name of your component in the EJBServer
- `<PACKAGE_NAME>` is the name of your package in the EJBServer
- `<CLASS_NAME>` is the name of the Java™ class

## Examples of data fetcher classes

### Example 1: A single data fetcher for a GraphQL API

In this example, an API named `readIntegratedCase` is defined in a schema. The API returns a `DOMIntegratedCase` object, where one of the attributes is a further nested list of `DOMBenefit` objects.

The underlying facade method `DOMIntegratedCaseGQL.readIntegratedCase()` facade method in the EJBServer that the data fetcher class will wrap takes a `DOMCaseID` input struct.
It also returns a `DOMIntegratedCase` struct, which contains a nested list of `DOMBenefit` structs. The facade method populates all the struct attributes, including the nested list of benefits.

This struct name and its attributes are a match for what is defined in the schema for the API.

The following code outlines the schema definition:

```
type Query {
    readIntegratedCase(case_id: GQL_ID!): DOMIntegratedCase
}

type DOMIntegratedCase {
        id: GQL_ID
        reference: String
        registration_date: GQL_Date
        benefits: [DOMBenefit]
}

type DOMBenefit {
        id: GQL_ID
        reference: String
        effective_date: GQL_Date
}
```

The following code sample shows how to implement a data fetcher for the `DOMIntegratedCase`:

```
public class IntegratedCaseDataFetcher implements DataFetcher<DOMIntegratedCase> {

  @Override
  public List<DOMBenefit> get(final DataFetchingEnvironment env) throws Exception {

    /* assign values to the input struct from the GraphQL request parameters, which are available from the DataFetchingEnvironment object.
    */
    final DOMCaseID domCaseID = new DOMCaseID();
    domCaseID.case_id = env.getArgument("case_id");

    final String facadeClassName = "DOMBIntegratedCaseGQL";
    final String facadeMethodName = "readIntegratedCase";

    final DOMBenefitList benefitList = (DOMIntegratedCase) GraphQLUtils
      .callServer(facadeClassName, facadeMethodName, inputStruct);

    return benefitList;
  }
}
```

The case ID is passed as a parameter by the query. The following code outlines how you can get the ID:

```
domCaseID.case_id = env.getArgument("case_id");
```

### Example 2: Multiple data fetchers for a GraphQL API

Here, the same schema from the previous schema is used.

The following code outlines the schema definition:

```
type Query {
    readIntegratedCase(case_id: GQL_ID!): DOMIntegratedCase
}

type DOMIntegratedCase {
        id: GQL_ID
        reference: String
        registration_date: GQL_Date
        benefits: [DOMBenefit]
}

type DOMBenefit {
        id: GQL_ID
        reference: String
        effective_date: GQL_Date
}
```

However, for this example two underlying facade methods must be used to retrieve all the data for the API.

The `DOMIntegratedCaseGQL.readIntegratedCase()` method is still to be used to retrieve details of the integrated case, and it still returns a `DOMIntegratedCase` struct.
However in this example the `DOMIntegratedCase` struct does not contain a nested list of `DOMBenefit` structs. The data fetcher implementation is identical to the first example.

 Use a second facade method `DOMBenefitGQL.listBenefitsByIntCase()` to retrieve details about the benefits for an integrated case. It returns a `DOMBenefitList` struct, which contains a nested list of `DOMBenefit` structs.
 This facade method requires the benefit ID as an input.

The following code sample shows how a data fetcher for the list of benefits must be implemented:

```
public class BenefitListDataFetcher implements DataFetcher<List<DOMBenefit>> {

  @Override
  public List<DOMBenefit> get(final DataFetchingEnvironment env) throws Exception {

    /* assign values to the input struct from the GraphQL request parameters, which are available from the DataFetchingEnvironment object.
    */
    final DOMCaseID domCaseID = new DOMCaseID();
    final DOMIntegratedCase domIntegratedCase = (DOMIntegratedCase) env.getSource();
    domCaseID.case_id = domIntegratedCase.id;

    final String facadeClassName = "DOMBenefitGQL";
    final String facadeMethodName = "listBenefitsByIntCase";


    final DOMBenefitList benefitList = (DOMBenefitList) GraphQLUtils
      .callServer(facadeClassName, facadeMethodName, inputStruct);

    return benefitList;
  }
}
```

When the readIntegratedCase API is invoked, the benefit ID is not sent as a parameter in the request.
The ID is contained in the `DOMIntegratedCase` struct that
is returned by the higher-level data fetcher. The GraphQL
server stores the responses of each data fetcher
as it traverses through the nodes
of the data objects in the `DataFetchingEnvironment`
context object.

The following code outlines how the benefit ID can be retrieved from the response of the IntegratedCaseDataFetcher that is stored in the context object:

```
final DOMIntegratedCase domIntegratedCase = (DOMIntegratedCase) env.getSource();
domCaseID.case_id = domIntegratedCase.id;
```
