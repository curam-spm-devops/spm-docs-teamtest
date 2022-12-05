# GraphQL directives for code items and frequency patterns

A directive in GraphQL indicates an extra configuration for a field.

The following list outlines the two Cúram directives in the GraphQL server:

1. The `@code` directive.
2. The `@frequency` directive.

These directives are used for the special handling of Java attributes that are used for code items and frequency patterns and that result in the Java attribute being converted into an object with multiple attributes.

The creation of extra directives is not supported.

## Codes

A facade method might return a struct that contains an attribute that was modeled in RSA with a domain definition based on a CODETABLE_CODE definition to denote that it contains a value of a code item from a code table.

In the GraphQL schema, any fields in an object type definition that correspond to a struct attribute with a CODETABLE_CODE domain definition must be defined by using the `CodeItem` type and by using the `@code` directive. The following snippet outlines an example:

```
type Case 
	id: GQL_ID
	status: CodeItem @code 
```

As the `CodeItem` type is defined in the schema, it does not need to be added. The following snippet specifies the definition:

```
type CodeItem
 	code: String
 	description: String
 	tablename: String
```

where `code` contains the code value, `description` contains a localized description of the code, and `tablename` contains the name of the code table to which the code belongs.

The following example shows how a JSON response for an API that includes how the preceding `Case` type might look:

```
"data": {
	"case": {
		"id": "123456789",
		"status": {
			"code": "RST1",
			"description": "Open",
			"tableName": "CaseStatus"
		}
	}
}
```

## Frequency patterns

A facade method might return a struct that contains an attribute that was modeled in RSA with a domain definition based on a FREQUENCY_PATTERN definition to denote that it contains a value of a frequency pattern.

In the GraphQL schema, any fields in an object type definition that correspond to a struct attribute with a FREQUENCY_PATTERN domain definition must be defined by using the `FrequencyItem` type and by using the `@frequency` directive.

The following snippet outlines an example:

```
type Payment 
	id: GQL_ID
	delivery_frequency: FrequencyItem @frequency
```

As the `FrequencyItem` type is already defined in the schema, it does not need to be added. The following snippet specifies the definition:

```
type FrequencyItem
 	value: String
 	description: String
```

where `value` contains the frequency pattern value and `description` contains a localized description of the pattern.

The following example shows how a JSON response for an API that includes the preceding `Payment` type might look:

```
"data": {
	"payment": {
		"id": "123456789",
		"delivery_frequency": {
			"value": "10010011",
			"description": "Recur every 234 week(s) on Monday"
		}
	}
}
```
