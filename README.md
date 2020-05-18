# CountryLibrary

A small extension to handle countries within Swift
![Swift](https://github.com/satan87/CountryLibrary/workflows/Swift/badge.svg?branch=master)

You have a country Struct with 
- The Country Code
- The Country Name
- The Country Flag



Code Example :


## *All countries from Swift Locale*
```
CountryLibrary.countries
```

*Already ordered by name*


## *To retrieve a Country from a string*

By Country Code
```
"FR".country(by: .code)
```
By Country Name
```
"Canada".country(by: .name)
```

