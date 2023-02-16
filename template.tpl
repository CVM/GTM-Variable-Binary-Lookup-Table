___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Binary Lookup Table",
  "categories": ["UTILITY"],
  "description": "Simplified lookup table that returns a binary output (boolean true/false) based on whether a match was found or not.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "inputVariable",
    "displayName": "Input Variable",
    "macrosInSelect": true,
    "selectItems": [],
    "simpleValueType": true,
    "help": "The value of this field will be used as a key to lookup a particular value in the list of values below."
  },
  {
    "type": "RADIO",
    "name": "matchType",
    "displayName": "Match Type",
    "radioItems": [
      {
        "value": "exact",
        "displayValue": "Exact",
        "help": "Values must exactly match the input variable."
      },
      {
        "value": "regex",
        "displayValue": "Regular Expression",
        "help": "Values are evaluated as Regular Expressions."
      }
    ],
    "simpleValueType": true
  },
  {
    "type": "CHECKBOX",
    "name": "caseSensitive",
    "checkboxText": "Case-sensitive",
    "simpleValueType": true,
    "help": "Enable strict case-sensitive matching."
  },
  {
    "type": "SIMPLE_TABLE",
    "name": "values",
    "simpleTableColumns": [
      {
        "defaultValue": "",
        "displayName": "Values",
        "name": "value",
        "type": "TEXT",
        "valueHint": "",
        "isUnique": false
      }
    ],
    "alwaysInSummary": false,
    "newRowButtonText": "Add row"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

let input = data.inputVariable;
let matchType = data.matchType;
let output = false;

if (data.caseSensitive === false) input = input.toLowerCase();

if (data.values !== undefined) {
  for (let i=0;i<data.values.length;i++) {
    let value = data.values[i].value;
    if (data.caseSensitive === false) value = value.toLowerCase();
    if (value !== "") {
      if (matchType === "exact" && input === value) output = true;
      if (matchType === "regex" && input.match(value)) output = true;
    }
  }
}

return output;


___TESTS___

scenarios:
- name: Exact match, case-insensitive, multiple values
  code: |-
    let variableResult = runCode({
      "inputVariable": "https://yourdomain.com/products",
      "matchType": "exact",
      "caseSensitive": false,
      "values": [{
        "value": "HTTPS://YOURDOMAIN.COM/CATEGORY",
      },{
        "value": "HTTPS://YOURDOMAIN.COM/PRODUCTS",
      }]
    });
    assertThat(variableResult).isEqualTo(true);
- name: Exact match, case-insensitive, single value
  code: |-
    let variableResult = runCode({
      "inputVariable": "https://yourdomain.com/products",
      "matchType": "exact",
      "caseSensitive": false,
      "values": [{
        "value": "HTTPS://YOURDOMAIN.COM/PRODUCTS"
      }]
    });
    assertThat(variableResult).isEqualTo(true);
- name: Exact match, case-insensitive, no values
  code: |-
    let variableResult = runCode({
      "inputVariable": "https://yourdomain.com/products",
      "matchType": "exact",
      "caseSensitive": false
    });
    assertThat(variableResult).isEqualTo(false);
- name: Exact match, case-sensitive, multiple values
  code: |-
    let variableResult = runCode({
      "inputVariable": "https://yourdomain.com/products",
      "matchType": "exact",
      "caseSensitive": true,
      "values": [{
        "value": "HTTPS://YOURDOMAIN.COM/CATEGORY",
      },{
        "value": "HTTPS://YOURDOMAIN.COM/PRODUCTS",
      }]
    });
    assertThat(variableResult).isEqualTo(false);
- name: Exact match, case-sensitive, single value
  code: |-
    let variableResult = runCode({
      "inputVariable": "https://yourdomain.com/products",
      "matchType": "exact",
      "caseSensitive": true,
      "values": [{
        "value": "HTTPS://YOURDOMAIN.COM/PRODUCTS"
      }]
    });
    assertThat(variableResult).isEqualTo(false);
- name: Exact match, case-sensitive, no values
  code: |-
    let variableResult = runCode({
      "inputVariable": "https://yourdomain.com/products",
      "matchType": "exact",
      "caseSensitive": true
    });
    assertThat(variableResult).isEqualTo(false);
- name: Regex match, case-insensitive, multiple values
  code: |-
    let variableResult = runCode({
      "inputVariable": "https://yourdomain.com/products",
      "matchType": "regex",
      "caseSensitive": false,
      "values": [{
        "value": "^HTTPS://([^/]+)/CATEGORY",
      },{
        "value": "^HTTPS://([^/]+)/PRODUCTS",
      }]
    });
    assertThat(variableResult).isEqualTo(true);
- name: Regex match, case-insensitive, single value
  code: |-
    let variableResult = runCode({
      "inputVariable": "https://yourdomain.com/products",
      "matchType": "regex",
      "caseSensitive": false,
      "values": [{
        "value": "^HTTPS://YOURDOMAIN\\.COM/(PRODUCTS|CATEGORY)"
      }]
    });
    assertThat(variableResult).isEqualTo(true);
- name: Regex match, case-insensitive, no values
  code: |-
    let variableResult = runCode({
      "inputVariable": "https://yourdomain.com/products",
      "matchType": "regex",
      "caseSensitive": false
    });
    assertThat(variableResult).isEqualTo(false);
- name: Regex match, case-sensitive, multiple values
  code: |-
    let variableResult = runCode({
      "inputVariable": "https://yourdomain.com/products",
      "matchType": "regex",
      "caseSensitive": true,
      "values": [{
        "value": "^HTTPS://([^/]+)/CATEGORY",
      },{
        "value": "^HTTPS://([^/]+)/PRODUCTS",
      }]
    });
    assertThat(variableResult).isEqualTo(false);
- name: Regex match, case-sensitive, single value
  code: |-
    let variableResult = runCode({
      "inputVariable": "https://yourdomain.com/products",
      "matchType": "regex",
      "caseSensitive": true,
      "values": [{
        "value": "^HTTPS://YOURDOMAIN\\.COM/(PRODUCTS|CATEGORY)"
      }]
    });
    assertThat(variableResult).isEqualTo(false);
- name: Regex match, case-sensitive, no values
  code: |-
    let variableResult = runCode({
      "inputVariable": "https://yourdomain.com/products",
      "matchType": "regex",
      "caseSensitive": true
    });
    assertThat(variableResult).isEqualTo(false);
setup: ''


___NOTES___

Created on 16/02/2023, 22:38:39


