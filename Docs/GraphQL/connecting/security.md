# Security

When you access any GraphQL API in Social Program Management, you must be an authenticated user with valid authorization permissions for the relevant facade methods.

## Authentication

Before you can make any GraphQL queries, you must authenticate with the Social Program Management application. For more information about authentication, see [Cúram REST API security](../MSDK/msdk_ctr_security.html).

## Authorization

To access the API resource, authenticated users require sufficient authorization permissions. For users without permission, an error is returned in the query response body. Permissions are given to the underlying facades of a GraphQL API by using security identifiers (SIDs).

To better secure what authenticated users can access, remove SIDs from the database for any unused GraphQL API facade methods.

## Cross Origin Request Forgery (CORS)

For security reasons, browsers restrict cross-origin HTTP requests that are initiated in a web application where the web application is hosted on a different server and port to the one where the GraphQL APIs are hosted.

However, the browser allows the HTTP request to proceed where, after it sends an initial OPTIONS request, the response from the server contains certain response headers that indicate to the browser that the request is allowed.

The REST infrastructure adds the response headers to an OPTIONS request from a browser where the domain that is set by the browser in the `origin` request header matches an allowlist of domains that are set in the `curam.rest.allowedOrigins` property.

For more information about the `curam.rest.allowedOrigins` property, see [Cúram REST configuration properties](../MSDK/r_custom_rest_properties.html).

## Cross Site Request Forgery (CSRF)

Cross Site Request Forgery (CSRF) applies only where the GraphQL query comes from a web application. The first line of defense against CSRF is the referer header. The value for the referer header that is sent in the request is set by the browser. The value cannot
be modified by JavaScript code. The value includes the domain of the server that the web application is hosted on.

A check is performed to ensure that the domain sent in the referer header matches an allowlist of domains that is set in the `curam.rest.refererDomains` property.

For any applications that are not web-based or for system-to-system communication, CSRF is not a factor. The referer header validation check  passes where the value matches the scheme name of `curam://`. For example `curam://<name>`, where `<name>` can be any
string name.

The REST infrastructure also optionally supports token-based protection as a second line of defense. For more information, see [Cross-Site Request Forgery (CSRF) protection for RESTful web services](../MSDK/msdk_c_CSRF.html).

## Extra response headers

The following list outlines the response headers and values that are included in every response from a GraphQL request:

- X-XSS-PROTECTION=1; mode=block
- X-FRAME-OPTIONS=deny
- X-CONTENT-TYPE-OPTIONS=nosniff

The headers are used to combat cross-site scripting, click-jacking, and mime-type sniffing attacks.
