# MGEDateFormatter

**MGEDateFormatter** provides a set of extensions and to NSDate and NSDateFormatter to build a nice API whch simplify the conversion of NSDate to NSString and back. 

Creating a `NSDateFormatter` is an expensive task. For this reason, **MGEDateFormatter** takes care of caching the created `NSDateFormatter` in order to reuse them along the lifecycle of your app.

## Installing MGEDateFormatter

##### Using CocoaPods

Add one of more of the following to your `Podfile`:

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
let strign = date.string(withDateStyle: .MediumStyle, timeStyle: .NoStyle, locale: spanishLocale)
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
let strign = date.string(withTemplate: "MMMyyyy", locale: spanishLocale)
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
let strign = date.string(withFormat: "MM/dd/yyyy HH:mm:ss", locale: spanishLocale)
````


### String to NSDate

In the same way, there is as well three equivalent ways to create a `NSDate` from a `String`. The thee of them come as `NSDate` initializers:

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


### Custom formatters

---


## Contact

[Manuel García-Estañ Martínez](http://github.com/ManueGE)  
[@manueGE](https://twitter.com/ManueGE)

## License

MGEDateFormatter is available under the [MIT license](LICENSE.md).