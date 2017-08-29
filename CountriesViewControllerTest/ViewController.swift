//
//  ViewController.swift
//  CountriesViewControllerTest
//
//  Created by Luca Becchetti on 29/08/17.
//  Copyright © 2017 Luca Becchetti. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CountriesViewControllerDelegate {

    @IBOutlet weak var singleSelection: UISwitch!
    @IBOutlet weak var results: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        results.text = ""
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
        //countriesViewController.selectedCountries = Countries.countriesFromCountryCodes(["AL"])
        
        /// Allow or disallow multiple selection
        countriesViewController.allowMultipleSelection = !singleSelection.isOn
        
        /// Set delegate
        countriesViewController.delegate = self
        
        /// Show
        CountriesViewController.Show(countriesViewController: countriesViewController, to: self)
        
    }

    /// MARK: CountriesViewControllerDelegate
    
    func countriesViewController(_ countriesViewController: CountriesViewController, didSelectCountries countries: [Country]) {
        
        var res = ""
        countries.forEach { (co) in
            res = res + co.name + "\n";
        }
        results.text = res
        
    }

    func countriesViewControllerDidCancel(_ countriesViewController: CountriesViewController) {
        
        results.text = "user hass been tap cancel\n"
        
    }
    
    func countriesViewController(_ countriesViewController: CountriesViewController, didSelectCountry country: Country) {
        
        results.text = country.name+" selected\n"
        
    }
    
    func countriesViewController(_ countriesViewController: CountriesViewController, didUnselectCountry country: Country) {
        
        results.text = country.name+" unselected\n"
        
    }
    
}

