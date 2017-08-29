# CountriesViewController - A view controller that allow user to select a countries. It supports single or multiple mode
<p align="center" >
  <img src="https://user-images.githubusercontent.com/16253548/29821924-f965e95e-8cc9-11e7-903a-2ae95269a6f3.png" width=400px alt="CountriesViewController" title="CountriesViewController">
</p>

[![Version](https://img.shields.io/badge/pod-0.1.0-blue.svg)](https://cocoapods.org/pods/CountriesViewController) [![License](https://img.shields.io/github/license/mashape/apistatus.svg)](https://cocoapods.org/pods/CountriesViewController) [![Platform](https://img.shields.io/badge/platform-ios-lightgrey.svg)](https://cocoapods.org/pods/InAppNotify) [![Swift3](https://img.shields.io/badge/swift3-compatible-brightgreen.svg)](https://cocoapods.org/pods/InAppNotify)

Usually during development i have a needed to select a country from list, this simple controller enable you to display a countries list, in a current locale language, and select them. Choose CountriesViewController for your next project, I'll be happy to give you a little help!

<p align="center" >★★ <b>Star our github repository to help us!, or <a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=BZD2RPBADPA6G" target="_blank"> ☕ pay me a coffee</a></b> ★★</p>
<p align="center" >Created by <a href="http://www.lucabecchetti.com">Luca Becchetti</a></p>


## Screenshots

<p align="center" >
<img src="https://user-images.githubusercontent.com/16253548/29822148-c45b0fb8-8cca-11e7-9ed0-f3a235bc927b.png" width="33%">
<img src="https://user-images.githubusercontent.com/16253548/29822150-c4907464-8cca-11e7-95a5-58ea23db5674.png" width="33%">
<img src="https://user-images.githubusercontent.com/16253548/29822149-c48b0e98-8cca-11e7-9ad5-fdeff551a984.png" width="33%">
</p>


## Requirements

  - iOS 9+
  - swift 3.0
  
## Main features
Here's a highlight of the main features you can find in CountriesViewController:
* **Current Locale Translations** Countries name are displayed using current locale
* **Single or multiple**. You can use selection as single selection or multiple selection 

## You also may like

Do you like `CountriesViewController`? I'm also working on several other opensource libraries.

Take a look here:

* **[InAppNotify](https://github.com/lucabecchetti/InAppNotify)** - Manage in app notifications
* **[SwiftMultiSelect](https://github.com/lucabecchetti/SwiftMultiSelect)** - Generic multi selection tableview
* **[SwiftMulticastProtocol](https://github.com/lucabecchetti/SwiftMulticastProtocol)** - send message to multiple classes

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like InAppNotify in your projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

#### Podfile

To integrate CountriesViewController into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

target 'TargetName' do
  use_frameworks!
  pod 'CountriesViewController'
end
```

Then, run the following command:

```bash
$ pod install
```

## How to use

First of all import library in your project

```swift
import CountriesViewController
```

The basic code to show a simple notification is:

```swift
//If you are in a UIViewController

let countriesViewController = CountriesViewController()
countriesViewController.delegate = self
CountriesViewController.Show(countriesViewController: countriesViewController, to: self)
```

You have to implement the CountriesViewControllerDelegate also:

```swift
extension YourViewController : CountriesViewControllerDelegate{
  /// MARK: CountriesViewControllerDelegate
    
    func countriesViewController(_ countriesViewController: CountriesViewController, didSelectCountries countries: [Country]){
        
        countries.forEach { (co) in
            print(co.name);
        }
    }

    func countriesViewControllerDidCancel(_ countriesViewController: CountriesViewController) {
        
        results.text = "user hass been tap cancel\n"
        
    }
    
    func countriesViewController(_ countriesViewController: CountriesViewController, didSelectCountry country: Country) {
        
        print(country.name+" selected")
        
    }
    
    func countriesViewController(_ countriesViewController: CountriesViewController, didUnselectCountry country: Country) {
        
        print(country.name+" unselected")
        
    }
}
```

### Customization

you can customize this parameters during inizialization:

```swift
/// Create a controller
let countriesViewController = CountriesViewController()
        
/// Show major country (this countries are displayed in top of tableview, before each others)
countriesViewController.majorCountryLocaleIdentifiers = ["GB", "US", "IT", "DE", "RU", "BR", "IN"]
        
/// Set initial selected countries
//countriesViewController.selectedCountries = Countries.countriesFromCountryCodes(["AL"])
        
/// Allow or disallow multiple selection
countriesViewController.allowMultipleSelection = true
        
/// Set delegate
countriesViewController.delegate = self
        
/// Show
CountriesViewController.Show(countriesViewController: countriesViewController, to: self)
```

## Projects using CountriesViewController

- Frind - [www.frind.it](https://www.frind.it) 

### Your App and InAppNotify
I'm interested in making a list of all projects which use this library. Feel free to open an Issue on GitHub with the name and links of your project; we'll add it to this site.

## Credits & License
CountriesViewController is owned and maintained by [Luca Becchetti](http://www.lucabecchetti.com) 

As open source creation any help is welcome!

The code of this library is licensed under MIT License; you can use it in commercial products without any limitation.

The only requirement is to add a line in your Credits/About section with the text below:

```
Countries selection by CountriesViewController - http://www.lucabecchetti.com
Created by Becchetti Luca and licensed under MIT License.
```
## About me

I am a professional programmer with a background in software design and development, currently developing my qualitative skills on a startup company named "[Frind](https://www.frind.it) " as Project Manager and ios senior software engineer.

I'm high skilled in Software Design (10+ years of experience), i have been worked since i was young as webmaster, and i'm a senior Php developer. In the last years i have been worked hard with mobile application programming, Swift for ios world, and Java for Android world.

I'm an expert mobile developer and architect with several years of experience of team managing, design and development on all the major mobile platforms: iOS, Android (3+ years of experience).

I'm also has broad experience on Web design and development both on client and server side and API /Networking design. 

All my last works are hosted on AWS Amazon cloud, i'm able to configure a netowrk, with Unix servers. For my last works i configured apache2, ssl, ejabberd in cluster mode, Api servers with load balancer, and more.

I live in Assisi (Perugia), a small town in Italy, for any question, [contact me](mailto:luca.becchetti@brokenice.it)
