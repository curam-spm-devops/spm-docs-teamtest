# Error handling in GraphQL

Where an error occurs in GraphQL while a query is being processed, the response is still a `200 OK` response because many queries might be combined into one.

As a result, some queries might pass while some fail. Therefore, a single error response code cannot be used to reflect passing and failing. Instead, GraphQL adds an `errors` object, in addition to the `data`  object, to the response body.

## Example

In the example that follows, only one query was included in the request. Since no data was returned, the 'data' attribute is set to 'null'. If multiple queries were combined and only one failed, then the 'data' object contains the responses of the successful
query while the 'errors' object contains the information of an unsuccessful query.

The underlying graphql libraries assign the values for the `message`, `locations`, and `path` attributes and the `classification` attribute inside the `extensions` object.

The `path` attribute contains the name of the query that was called and that is causing the error. The name of the query is useful where multiple queries were combined into one so that the query that caused the error can be identified.

The `message` attribute contains information that might be helpful for debugging. Do not display the information on a user interface.

The GraphQL server in the REST application adds information that is specific to the error to the `extensions` object.

```
{
  "errors": [
    {
      "message": "Variable 'case_id' has an invalid value. Unable to parse variable value as a Long",
      "locations": [
        {
          "line": 1,
          "column": 26
        }
      ],
      "path": "/readCase",
      "extensions": {
        "classification": "ValidationError"
      }
    }
  ],
  "data": {
    "readCase": null
  }
}
```

## Structure of the error response

The error response differentiates between client and internal errors.

### Client errors

Client errors contain localized messages to display on a user interface to the user. A list of error messages might be contained in the response.

The following list outlines one of the two places where the errors originate in the background:

- As an `AppException` that is produced from the underlying facade method in the EJBServer.
- As a `ConversionException` when it validates user input parameters against the domain definition for the corresponding input struct that is being sent to a facade method.

Errors that originate as `AppExceptions` contain a unique `string identifier`. Errors that originate as `ConversionExceptions` contain a unique `code identifier`.

The following code outlines the structure of the 'extensions' object:

```
"extensions": {
  "code":<top-level code of -130002 or -150601>
  "client_error": true
  "error_messages": [
    { 
      "message": <localized message, suitable for displaying to end user>
        "code": <unique code, if originating as a ConversionException when validating user input params against domain definitions>,
        "message_id": <unique string id, if originating as an AppException>
      }
  ]
}
```

The following example outlines a full error response body for a client error:

```
{
  "errors": [
    {
      "message": "Exception while fetching data (/readIntegratedCase) : ERROR: The application server reported one or more exceptions",
      "locations": [
        {
          "line": 2,
          "column": 3
        }
      ],
      "path": [
        "readIntegratedCase"
      ],
      "extensions": {
        "code": -130002,
        "client_error": true,
        "error_messages": [
          {
            "message": "You do not have maintenance rights for this case. Please contact your security administrator.",
            "message_id": "ERR_CASESECURITY_CHECK_RIGHTS"
          }
        ],
        "classification": "DataFetchingException"
      }
    }
  ],
  "data": {
    "readIntegratedCase": null
  }
}
```

For client errors, the cause of the error and the stack trace is logged only where tracing is set to a level of `trace_on` or higher in the `curam.trace` system property.

### Internal errors

All other errors are considered internal errors. The cause of the error is not displayed to the user. Regardless of the cause of the error, the error code `-150600` is used.

To be consistent with the client errors, the structure of the extensions object still contains a nested list of messages. However, the list contains only one entry. The message is a localized generic error message to indicate that an error occurred.
The top-level code of `-150600` is repeated for each error.

Regardless of the tracing level, the cause of the error and the stack trace is logged.

If tracing is set to a level of `trace_on` or higher, further information about the cause of the error is included for debugging purposes. The information varies depending on the exception type of the cause of the error.

The following code outlines the structure of the 'extensions' object:

```
"extensions": {
  "code": -150600
  "client_error": false
  "error_messages": [
    { 
      "code": -150600,
      "message": <localized message to indicate something went wrong internally. May be displayed on a UI if desired.>
    }
  ]
}
```

The following code outlines an example of a full error response body for a client error:

```
{
  "errors": [
    {
      "message":"Cannot retrieve information at this time. Please contact your administrator.",
      "extensions":
        {
          "code":-150600,
          "client_error":false,
          "error_messages": [
            {
              "message":"Cannot retrieve information at this time. Please contact your administrator.",
              "code":-150600
            }
          ],
          "debug_info": {
            "root_cause_exception_type":"curam.rest.exception.CuramWebApplicationException",
            "root_cause_message":"The request is forbidden as the specified Referer header is not allowed.",
            "root_cause_code":-150210
          }
        }
      }
    ],
  "data": null
}
```
