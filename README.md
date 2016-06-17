# MGEDateFormatter

**MGEDateFormatter** provides a set of extensions to NSDate and NSDateFormatter to build a nice API which simplify the conversion from NSDate to NSString and back. 

Creating a `NSDateFormatter` is an expensive task. For this reason, **MGEDateFormatter** takes care of caching the created `NSDateFormatter` in order to reuse them along the lifecycle of your app.

The aim of this project is to have a nice API to get strings representations from `NSDate` instaces:

````
let stringWithTemplate = date.string(withTemplate: "MMMMyyyy")
let stringWithFormat = date.string(withFormat: "MM/yy")
let monthAndYearString = date.string(with: .monthAndYear)
````

Keep reading to know how!

## Installation

#### CocoaPods

Add the following to your `Podfile`:

````
pod 'MGEDateFormatter'
````

Then run `$ pod install`.

And finally, in the classes where you need **MGEDateFormatter**: 

````
import MGEDateFormatter
````

If you don’t have CocoaPods installed or integrated into your project, you can learn how to do so [here](http://cocoapods.org).

## Usage

### NSDate to String

There are three main ways to convert a `NSDate` to a `String`. 

##### Using NSDateFormatterStyle

````
let date = NSDate()
let string = date.string(withDateStyle: .ShortStyle, timeStyle: .ShortStyle)
````

if needed, you can provide a custom location to perform the conversion: 

````
let spanishLocale = NSLocale(localeIdentifier: "es")
let date = NSDate()
let string = date.string(withDateStyle: .MediumStyle, timeStyle: .NoStyle, locale: spanishLocale)
````

##### Using format from template
````
let date = NSDate()
let string = date.string(withTemplate: "MMMyyyy")
````

if needed, you can provide a custom location to perform the conversion: 

````
let spanishLocale = NSLocale(localeIdentifier: "es")
let date = NSDate()
let string = date.string(withTemplate: "MMMyyyy", locale: spanishLocale)
````

##### Using date format
````
let date = NSDate()
let string = date.string(withFormat: "MM/dd/yyyy HH:mm:ss")
````

if needed, you can provide a custom location to perform the conversion: 

````
let spanishLocale = NSLocale(localeIdentifier: "es")
let date = NSDate()
let string = date.string(withFormat: "MM/dd/yyyy HH:mm:ss", locale: spanishLocale)
````


### String to NSDate

In the same way, there are three ways to create a `NSDate` from a `String`. The thee of them are provided as `NSDate` initializers:

##### Using NSDateFormatterStyle

````
let string = "11/18/83, 11:30 AM"
let convertedDate = NSDate(string: string, dateStyle: .ShortStyle, timeStyle: .ShortStyle)
````
**Note**: The convertedDate is an `Optional<NSDate>`, and will be `nil` if the string couldn't be parsed

if needed, you can provide a custom location to perform the conversion: 

````
let spanishLocale = NSLocale(localeIdentifier: "es")
let string = "18/11/83 11:30"
let convertedDate = NSDate(string: string, dateStyle: .ShortStyle, timeStyle: .ShortStyle, locale: spanishLocale)
````

##### Using format from template
````
let string = "November 18, 1983, 11:30"
let convertedDate = NSDate(string: string, template: "ddMMMMyyyyHHmm")
````
**Note**: The convertedDate is an `Optional<NSDate>`, and will be `nil` if the string couldn't be parsed

if needed, you can provide a custom location to perform the conversion: 

````
let spanishLocale = NSLocale(localeIdentifier: "es")
let string = "noviembre 18, 1983, 11:30"
let convertedDate = NSDate(string: string, template: "ddMMMMyyyyHHmm", locale: spanishLocale)
````

##### Using date format
````
let string = "18/November/1983 11:30"
let convertedDate = NSDate(string: string, format: "dd/MMMM/yyyy HH:mm")
````
**Note**: The convertedDate is an `Optional<NSDate>`, and will be `nil` if the string couldn't be parsed

if needed, you can provide a custom location to perform the conversion: 

````
let spanishLocale = NSLocale(localeIdentifier: "es")
let string = "18/noviembre/1983 11:30"
let convertedDate = NSDate(string: string, format: "dd/MMMM/yyyy HH:mm", locale: spanishLocale)
````

### Best practices

In my own apps, I like to use **MGEDateFormatter** in this way: 

##### 1- Create a `enum` with my date formatter templates and/or formats: 

Usually I have just a set of few templates and/or formats to use. I wrap them into a couple of `enum`:

````
enum DateTemplate: String {
    case monthAndYear = "MMMyyyy"
    case fullShortDate = "ddMMyy"
}

enum DateFormat: String {
    case fullDate = "dd/MM/yyyy"
    case fullDateAndTime = "dd/MM/yyyy HH:mm:ss"
}
````

#### 2- Create a `NSDate` extension:

I create an extension that wraps the `MGEDateFormatter` methods to accept values of the defined `enum`:

````
extension NSDate {
    
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

````
let date = NSDate()

// Templates
let monthAndYearString = date.string(with: .monthAndYear)
let fullShortDateString = date.string(with: .fullShortDate)

let dateFromMonthAndYear = NSDate(string: "11/1983", template: .monthAndYear)

// Formats
let fullDateString = date.string(with: .fullDate)
let fullDateAndTimeString = date.string(with: .fullDateAndTime)

let dateFromfullDateString = NSDate(string: "11/18/1983", format: .fullDate)
````


### Custom formatters

Aren't the three methods provided to format strings enough for you? Don't worry, you can still take advantage of **MGEDateFormatter**. 

If you want to add further customization to your formatter, you can use the `DateFormatterProvider` protocol. 

To conform this protocol you have to override a property (`cacheKey`) and a function (`configure(_: NSDateFormatter)`). Here you have an example: 


````
class MyDateFormatterProvider: DateFormatterProvider {
    let cacheKey: String
    let format: String
    
    init(format: String) {
        self.format = format
        self.cacheKey = "MyConfigurator(\(format))"
    }
    
    func configure(formatter: NSDateFormatter) {
        formatter.dateFormat = format
        formatter.monthSymbols = ["JN", "FB", "MR", "AP", "MY", "JN", "JL", "AG", "SP", "OT", "NV", "DC"]
        // whatever configuration you need
    }
}

````

and then, later:

````
let myProvider = MyDateFormatterProvider(format: "dd MMMM yyyy")

// from date to string
let date = NSDate()
let myCustomFormatString = date.string(with: myProvider)

// from string to date
let string = "18 NV 1983"
let convertedDate = NSDate(string: string, provider: myProvider)

````
The `NSDateFormatter` used to serialize the `NSDate` or the `String` will be cached under the defined `cacheKey` and will be nicely reused if it is needed again. In other words, if in any other point of the app we create a new provider with the same format as this

````
let otherProvider = MyDateFormatterProvider(format: "dd MMMM yyyy")

// from date to string
let otherDate = NSDate()
let otherCustomFormatString = date.string(with: otherProvider)
````

the `NSDateFormatter` will be reused.

---


## Contact

[Manuel García-Estañ Martínez](http://github.com/ManueGE)  
[@manueGE](https://twitter.com/ManueGE)

## License

MGEDateFormatter is available under the [MIT license](LICENSE.md).