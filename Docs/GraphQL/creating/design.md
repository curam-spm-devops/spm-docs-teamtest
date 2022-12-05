# Designing the implementation of a GraphQL query

The following outlines a guide on how to design your own GraphQL APIs.

## About this task

The simplest design for a GraphQL API is to have one single datafetcher wired to the query, and this in turn calls to an EJBServer facade method to retrieve data. Values for all attributes in the return struct will be populated by the facade method.

As GraphQL gives the client the ability to construct a query that only requests attributes they want, the final JSON response body returned will only include this data.
However the database reads and processing will still occur in the server if only one facade method is used to retrieve all data for the invoked API.

There are however a number of approaches to designing and splitting the retrievel of data between multiple smaller datafetchers and facades for an API, so they only get invoked if the client requests those particluar attributes.
This also facilitates the designing of facades and data into domains so they are modularised and re-useable.

**Note:** It is important to understand the business use cases of who may consume the GraphQL API, as there is no point to split into separate datafetchers if there is no use case where only certain attributes may be requested.
If the use cases determine that all attributes will be required all the time, then a single datafetcher and facade method is the best option.

The following sections give an example of designing APIs differently for the same underlying data.
In all approaches, under the hood the data retrieval is split between multiple datafetchers and corresponding facade methods, but they differ in the schema definition and the runtime wiring.

## Design Example

As an example, we can look at data for a benefit, including calculating information about the last payment. Under the hood, we will assume that two datafetchers (`BenefitsDataFetcher` and `PaymentsDataFetcher`) are already implemented,
and in turn each would call a different facade method in the EJBServer.

For this example, we can assume that there are two business use cases for the query as follows:

1. A mobile app that only displays the reference and status of the benefit.
2. The full SPM application that displays all of the details including payments.

So for the use case of the mobile app, doing calulations and reading data in relation to payments is wasteful processing.

## Approach 1

Approach 1 involves designing a single API, with multiple data fetchers wired to it. We can define a query named 'readBenefit', which returns all data relating to the benefit.
The schema definitions in the `schema.graphqls` file would be as follows:

```
extend type Query {
	readBenefit(id: GQL_ID): Benefit
}

type Benefit {
	id: GQL_ID
	reference: String
	type: CodeItem @code
	status: CodeItem @code
	effective_date: GQL_Date
	last_payment: {Payment}
}

type Payment {
	id: GQL_ID
	total_amount: GQL_Money
	credit_total_amount: GQL_Money
	debit_total_amount: GQL_Money
}
```

GraphQL provides the ability to wire a datafetcher to a particular attribute, in addition to wiring the top level datafetcher for the API.
So if a separate `PaymentsDataFetcher` datafetcher is defined in the runtime wiring for the `last_payment` attribute, this datafetcher will never get invoked when the mobile app only requests the `reference` and `status` attributes.

To achieve this, the `runtime_wiring.yaml` file would contain the following entries:

```
Query:
  - name: readBenefit
    data_fetcher: curam.core.graphql.datafetcher.BenefitsDataFetcher
FieldLevelWiring:
  - object_type: Benefit
    field:  last_payments
    data_fetcher: curam.core.graphql.datafetcher.PaymentsDataFetcher
```

## Approach 2

Approach 2 involves designing multiple APIs, with a single data fetcher wired to each API. The schema definitions in the `schema.graphqls` file would then be as follows:

```
extend type Query {
	readBenefit(id: GQL_ID): Benefit
	readLastPaymentForBenefit(id: GQL_ID): Payment
}

type Benefit {
	id: GQL_ID
	reference: String
	type: CodeItem @code
	status: CodeItem @code
	effective_date: GQL_Date
}

type Payment {
	id: GQL_ID
	total_amount: GQL_Money
	credit_total_amount: GQL_Money
	debit_total_amount: GQL_Money
}
```

The `runtime_wiring.yaml` file would contain the following entries:

```
Query:
  - name: readBenefit
    data_fetcher: curam.core.graphql.datafetcher.BenefitsDataFetcher
  - name: readLastPaymentsForBenefit
    data_fetcher: curam.core.graphql.datafetcher.PaymentsDataFetcher
```

For the mobile app use case, a query would be created to only invoke the `readBenefit` API.

For the SPM application use case, which also needs the information about the last payments, both the `readBenefit` and the `readLastPaymentsForBenefit` will need to be invoked.
However the client can construct a query that calls both APIs together. This is possible when you have the value for any input parameters for the second query, and are not dependant on the results of the first query.
The resulting response body will be identical to Approach 1, and also similarly to Approach 1, the `PaymentsDataFetcher` and underlying facade is never invoked for the mobile app use case.

## Approach 3

Approach 3 involves defining two different queries in the schema, one for each use case. This is achieved by extending the `Benefit` type and adding additional attributes to the extension.
The schema definitions in the `schema.graphqls` file would then be as follows:

```
extend type Query {
	readBenefit(id: GQL_ID): Benefit
	readBenefitWithPayments(id: GQL_ID): BenefitWithPayment
}

type Benefit {
	id: GQL_ID
	reference: String
	type: CodeItem @code
	status: CodeItem @code
	effective_date: GQL_Date
}

type BenefitWithPayment extends Benefit {
	last_payment: {Payment}
}

type Payment {
	id: GQL_ID
	total_amount: GQL_Money
	credit_total_amount: GQL_Money
	debit_total_amount: GQL_Money
}
```

The disadvantage with this approach is that it is more difficult to understand which query to use for which use case, and is not fully utilizing the benefits of GraphQL.

However at times this type approach may be necessary, particularly if using existing facades that have already been created for different use cases, even if the query is only wired to one datafetcher.

## Differences between the approaches

For all approaches, there is no major difference in the underlying code, only in the way the query has been defined in the schema and runtime_wiring files.
In this simple example, the main difference between the approaches is that the consumer needs to understand which queries contain which data. Therefore Approach 1 would be the more user-friendly approach.

The other main difference between approaches is when there are multiple queries, but the second query is dependant the value of an attribute that is returned in the response of the first query.
In this case the two queries would need to be called as separate requests, and the response of the first request parsed to get the data required to add to the second request.
So using Approach 1 could potentially mean that more data could be retrieved in one request, because the result returned by the first datafetcher is accesible to the other datafetchers wired to the API.

However a balance is required, where not too much data is added to a single API - for non-related data, the data should be divided into separate APIs that are not dependent on each other.
They may still be queried together in one request by a client.
