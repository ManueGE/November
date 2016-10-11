![November banner](https://raw.githubusercontent.com/ManueGE/November/master/images/banner.png)

---

# November

**November** provides a set of extensions to Date and DateFormatter to build a nice API which simplify the conversion from Date to NSString and back. 

Creating a `DateFormatter` is an expensive task. For this reason, **November** takes care of caching the created `DateFormatter` in order to reuse them along the lifecycle of your app.

The aim of this project is to have a nice API to get strings representations from `Date` instaces:

````swift
let stringWithStyles = date.string(dateStyle: .medium, timeStyle: .none)
let stringWithTemplate = date.string(withTemplate: "MMMMyyyy")
let stringWithFormat = date.string(withFormat: "MM/yy")
let monthAndYearString = date.string(with: .monthAndYear)
````

Keep reading to know how!

> This is the **Swift 3** version of the library. Check the **Swift 2** version [here](https://github.com/ManueGE/November/tree/swift_2).

## Installation

Add the following to your `Podfile`:

````ruby
pod 'November'
````

Then run `$ pod install`.

And finally, in the classes where you need **November**: 

````swift
import November
````

If you don’t have CocoaPods installed or integrated into your project, you can learn how to do so [here](http://cocoapods.org).

## Usage

### Date to String

There are three main ways to convert a `Date` to a `String`. 

##### Using DateFormatter.Style

````swift
let date = Date()
let string = date.string(dateStyle: .shortStyle, timeStyle: .shortStyle)
````

if needed, you can provide a custom locale to perform the conversion: 

````swift
let spanishLocale = Locale(localeIdentifier: "es")
let date = Date()
let string = date.string(dateStyle: .mediumStyle, timeStyle: .noStyle, locale: spanishLocale)
````

##### Using format from template
````swift
let date = Date()
let string = date.string(withTemplate: "MMMyyyy")
````

if needed, you can provide a custom locale to perform the conversion: 

````swift
let spanishLocale = Locale(localeIdentifier: "es")
let date = Date()
let string = date.string(withTemplate: "MMMyyyy", locale: spanishLocale)
````

##### Using date format
````swift
let date = Date()
let string = date.string(withFormat: "MM/dd/yyyy HH:mm:ss")
````

if needed, you can provide a custom locale to perform the conversion: 

````swift
let spanishLocale = Locale(localeIdentifier: "es")
let date = Date()
let string = date.string(withFormat: "MM/dd/yyyy HH:mm:ss", locale: spanishLocale)
````


### String to Date

In the same way, there are three ways to create a `Date` from a `String`. The thee of them are provided as `Date` initializers:

##### Using DateFormatter.Style

````swift
let string = "11/18/83, 11:30 AM"
let convertedDate = Date(string: string, dateStyle: .shortStyle, timeStyle: .shortStyle)
````
**Note**: The convertedDate is an `Optional<Date>`, and will be `nil` if the string couldn't be parsed

if needed, you can provide a custom locale to perform the conversion: 

````swift
let spanishLocale = Locale(localeIdentifier: "es")
let string = "18/11/83 11:30"
let convertedDate = Date(string: string, dateStyle: .shortStyle, timeStyle: .shortStyle, locale: spanishLocale)
````

##### Using format from template
````swift
let string = "November 18, 1983, 11:30"
let convertedDate = Date(string: string, template: "ddMMMMyyyyHHmm")
````
**Note**: The convertedDate is an `Optional<Date>`, and will be `nil` if the string couldn't be parsed

if needed, you can provide a custom locale to perform the conversion: 

````swift
let spanishLocale = Locale(localeIdentifier: "es")
let string = "noviembre 18, 1983, 11:30"
let convertedDate = Date(string: string, template: "ddMMMMyyyyHHmm", locale: spanishLocale)
````

##### Using date format
````swift
let string = "18/November/1983 11:30"
let convertedDate = Date(string: string, format: "dd/MMMM/yyyy HH:mm")
````
**Note**: The convertedDate is an `Optional<Date>`, and will be `nil` if the string couldn't be parsed

if needed, you can provide a custom locale to perform the conversion: 

````swift
let spanishLocale = Locale(localeIdentifier: "es")
let string = "18/noviembre/1983 11:30"
let convertedDate = Date(string: string, format: "dd/MMMM/yyyy HH:mm", locale: spanishLocale)
````

### Best practices

In my own apps, I like to use **November** in this way: 

##### 1- Create a `enum` with my date formatter templates and/or formats: 

Usually I have just a set of few templates and/or formats to use. I wrap them into a couple of `enum`:

````swift
enum DateTemplate: String {
    case monthAndYear = "MMMyyyy"
    case fullShortDate = "ddMMyy"
}

enum DateFormat: String {
    case fullDate = "dd/MM/yyyy"
    case fullDateAndTime = "dd/MM/yyyy HH:mm:ss"
}
````

#### 2- Create a `Date` extension:

I create an extension that wraps the `November` methods to accept values of the defined `enum`:

````swift
extension Date {
    
    // MARK: Helpers Date -> String
    
    func string(with template: DateTemplate) -> String {
        return string(withTemplate: template.rawValue)
    }
    
    func string(with format: DateFormat) -> String {
        return string(withFormat: format.rawValue)
    }
    
    // MARK: Helpers String -> Date
    
    convenience init?(string: String, template: DateTemplate) {
        self.init(string: string, template: template.rawValue)
    }
    
    convenience init?(string: String, format: DateFormat) {
        self.init(string: string, format: format.rawValue)
    }
}
````


#### 3- Call the methods from the extension:

Now, we have a nice, swifty, simple API to convert dates to strings and back: 

````swift
let date = Date()

// Templates
let monthAndYearString = date.string(with: .monthAndYear)
let fullShortDateString = date.string(with: .fullShortDate)

let dateFromMonthAndYear = Date(string: "11/1983", template: .monthAndYear)

// Formats
let fullDateString = date.string(with: .fullDate)
let fullDateAndTimeString = date.string(with: .fullDateAndTime)

let dateFromfullDateString = Date(string: "11/18/1983", format: .fullDate)
````


### Custom formatters

Aren't the three methods provided to format strings enough for you? Don't worry, you can still take advantage of **November**. 

If you want to add further customization to your formatter, you can use the `DateFormatterProvider` protocol. 

To conform this protocol you have to override a property (`cacheKey`) and a function (`configure(_: DateFormatter)`). Here you have an example: 


````swift
class MyDateFormatterProvider: DateFormatterProvider {
    let cacheKey: String
    let format: String
    
    init(format: String) {
        self.format = format
        self.cacheKey = "MyConfigurator(\(format))"
    }
    
    func configure(formatter: DateFormatter) {
        formatter.dateFormat = format
        formatter.monthSymbols = ["JN", "FB", "MR", "AP", "MY", "JN", "JL", "AG", "SP", "OT", "NV", "DC"]
        // whatever configuration you need
    }
}

````

and then, later:

````swift
let myProvider = MyDateFormatterProvider(format: "dd MMMM yyyy")

// from date to string
let date = Date()
let myCustomFormatString = date.string(with: myProvider)

// from string to date
let string = "18 NV 1983"
let convertedDate = Date(string: string, provider: myProvider)

````

The `DateFormatter` used to serialize the `Date` or the `String` will be cached under the defined `cacheKey` and will be nicely reused if it is needed again. In other words, if in any other point of the app we create a new provider with the same format as this


````swift
let otherProvider = MyDateFormatterProvider(format: "dd MMMM yyyy")

// from date to string
let otherDate = Date()
let otherCustomFormatString = date.string(with: otherProvider)
````

the `DateFormatter` will be reused.

#### No cached formatters
If you don't mind about caching formatters, you simply can use the `Date` extension to convert `Date` from/to `String` using a `DateFormatter`: 

````swift
let formatter = DateFormatter()
formatter.dateFormat = "MM/yyyy"

let string = Date().string(with: formatter)
let date = Date(string: "06/2016, formatter: formatter")
````

---


## Contact

[Manuel García-Estañ Martínez](http://github.com/ManueGE)  
[@manueGE](https://twitter.com/ManueGE)

## License

November is available under the [MIT license](LICENSE.md).