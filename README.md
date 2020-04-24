# CountryLibrary

A small extension to handle countries within Swift

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
"FR".countries(by: .code)
```
By Country Name
```
"Canada".countries(by: .name)
```
