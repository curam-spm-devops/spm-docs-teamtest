# Localization

GraphQL APIs can return certain data that is translatable into different languages. Examples include client error messages, code table descriptions, and other localizable text.

The language and locale is set for each GraphQL query that is based on the value that is sent in the `accept-language` request header. For example, if the `accept-language` request header is set to a value of `fr-CA` the server attempts to convert any localizable
fields
to the `fr-CA` locale. If no value is sent in the `accept-langauge` request header,
then the server assumes a default of `en`.

HTTP supports multiple values to be set for the `accept-language` header. However, only the highest priority value is used and all other languages are ignored. When you use this header priority, set only one locale.
