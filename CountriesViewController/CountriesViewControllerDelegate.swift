//
//  CountriesViewControllerDelegate.swift
//  CountriesViewController
//
//  Created by Luca Becchetti on 29/08/17.
//  Copyright © 2017 Luca Becchetti. All rights reserved.
//

import Foundation

/// Delegate
public protocol CountriesViewControllerDelegate {
    
    /// Comunicate delegates that controller has been closed
    ///
    /// - Parameter countriesViewController: countriesViewController
    func countriesViewControllerDidCancel(_ countriesViewController: CountriesViewController)
    
    
    /// Comunicate delegates that a country has been selected
    ///
    /// - Parameters:
    ///   - countriesViewController: countriesViewController
    ///   - country: a country selected
    func countriesViewController(_ countriesViewController: CountriesViewController, didSelectCountry country: Country)
    
    /// Comunicate delegates that a country has been unselected
    ///
    /// - Parameters:
    ///   - countriesViewController: countriesViewController
    ///   - country: a country unselected
    func countriesViewController(_ countriesViewController: CountriesViewController, didUnselectCountry country: Country)
    
    /// Comunicate delegates that some countries has been selected
    ///
    /// - Parameters:
    ///   - countriesViewController: countriesViewController
    ///   - countries: [Country]
    func countriesViewController(_ countriesViewController: CountriesViewController, didSelectCountries countries: [Country])
    
}
