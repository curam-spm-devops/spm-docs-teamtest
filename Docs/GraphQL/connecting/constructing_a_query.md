# Constructing a GraphQL query

A client decides what to add to a query by examining the GraphQL schema. The client then decides the APIs to call, and decides which attributes from the return object of the API to include in the response.

The details are sent in the request body when it calls the `POST https://<server>:<port>/Rest/graphql` endpoint.

## Examples of a request body for a GraphQL query

The following basic schema example defines two APIs and the two data objects that the APIs return:

```
type Query {
 readIntegratedCase(case_id: GQL_ID): IntegratedCase
 readPerson(person_id: GQL_ID): Person
}

type IntegratedCase {
 id: GQL_ID
 reference: String
 registration_date: GQL_Date
}

type Person {
 id: GQL_ID
 name: String
 date_of_birth: GQL_Date
}
```

The following snippet outlines the code in the request body for a query that starts the `readIntegratedCase` API and that requests only the reference of the case:

```
{
 "query":"{
  readIntegratedCase(case_id: "2012"){
   reference
  }
 }
}
```

The following JSON outlines an example of a response body from the preceding query:

```
{
  "data": {
    "readIntegratedCase": {
      "reference": "203"
    }
  }
}
```

The following snippet outlines the code in the request body for a query that starts both the `readIntegratedCase` and `readPerson` APIs and that requests all attributes for both entities:

```
{
 "query":"{
  readIntegratedCase(case_id: "2012"){
   id
   reference
   registration_date

  }  
  readPerson(person_id: "101"){
   id
   name
   date_of_birth
  }
 }
}
```

The following JSON outlines an example of a response body from the preceding query:

```
{
 "data": {
    "readExpectedNextPaymentByCaseID": null,
    "listNextPayments": null,
    "readIntegratedCase": {
      "id": "2012",
      "reference": "2012",
      "registration_date": "2020-04-14"
    },
    "readPerson": {
     "id": "101",
     "name": "Joe Bloggs",
     "date_of_birth": "1999-01-01"
    }
  }
}
```

For more information about how to create more complex queries and the use of fragments, see [Queries and Mutations](https://graphql.org/learn/queries/).
