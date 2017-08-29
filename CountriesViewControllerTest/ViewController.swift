//
//  ViewController.swift
//  CountriesViewControllerTest
//
//  Created by Luca Becchetti on 29/08/17.
//  Copyright © 2017 Luca Becchetti. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CountriesViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Action to launch a controller
    ///
    /// - Parameter sender: Any
    @IBAction func launch(_ sender: Any) {
        
        /// Create a controller
        let countriesViewController = CountriesViewController()
        
        /// Show major country
        countriesViewController.majorCountryLocaleIdentifiers = ["GB", "US", "IT", "DE", "RU", "BR", "IN"]
        
        /// Set initial selected
        countriesViewController.selectedCountries = Countries.countriesFromCountryCodes(["AL"])
        
        /// Allow or disallow multiple selection
        countriesViewController.allowMultipleSelection = false
        
        /// Set delegate
        countriesViewController.delegate = self
        
        /// Show
        CountriesViewController.Show(countriesViewController: countriesViewController, to: self)
        
    }

    /// MARK: CountriesViewControllerDelegate
    
    func countriesViewController(_ countriesViewController: CountriesViewController, didSelectCountries countries: [Country]) {
        
        countries.forEach { (co) in
            print(co.name)
        }
        
    }

    func countriesViewControllerDidCancel(_ countriesViewController: CountriesViewController) {
        
        print("user hass been tap cancel")
        
    }
    
    func countriesViewController(_ countriesViewController: CountriesViewController, didSelectCountry country: Country) {
        
        print(country.name+" selected")
        
    }
    
    func countriesViewController(_ countriesViewController: CountriesViewController, didUnselectCountry country: Country) {
        
        print(country.name+" unselected")
        
    }
    
}

