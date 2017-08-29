//
//  CountrySelectViewController.swift
//  CountrySelectViewController is a view contoller to select a country state
//
//  Created by Luca Becchetti on 29/08/17.
//  Copyright © 2017 Luca Becchetti. All rights reserved.
//
import UIKit
import Foundation
import CoreData

/// Class to select countries
public final class CountriesViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    public var unfilteredCountries          : [[Country]]! { didSet { filteredCountries = unfilteredCountries } }
    public var filteredCountries            : [[Country]]!
    public var majorCountryLocaleIdentifiers: [String] = []
    public var delegate                     : CountriesViewControllerDelegate?
    public var allowMultipleSelection       : Bool = true
    public var selectedCountries            : [Country] = [Country](){
        didSet{
            self.navigationItem.rightBarButtonItem?.isEnabled = self.selectedCountries.count > 0
        }
    }
    
    /// Lazy var for table view
    open fileprivate(set) lazy var tableView: UITableView = {
        
        let tableView:UITableView = UITableView()
        tableView.backgroundColor = .white
        return tableView
        
    }()
    
    /// Lazy var for table view
    open fileprivate(set) lazy var searchBar: UISearchBar = {
        
        let searchBar:UISearchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
        
    }()
    
    /// Lazy var for global stackview container
    open fileprivate(set) lazy var stackView: UIStackView = {
        
        let stackView           = UIStackView(arrangedSubviews: [self.searchBar,self.tableView])
        stackView.axis          = .vertical
        stackView.distribution  = .fill
        stackView.alignment     = .fill
        stackView.spacing       = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
        
    }()
    
    /// Calculate the nav bar height if present
    var cancelButton    : UIBarButtonItem!
    var doneButton      : UIBarButtonItem?
    
    private var searchString:String = ""
    
    /// Mark: viewDidLoad
    override public func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = allowMultipleSelection ? "Select Countries" : "Select Country"
        
        cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(CountriesViewController.cancel))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        if allowMultipleSelection{
            doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(CountriesViewController.done))
            self.navigationItem.rightBarButtonItem = doneButton
            self.navigationItem.rightBarButtonItem?.isEnabled = selectedCountries.count > 0
        }
        
        /// Configure tableVieew
        tableView.sectionIndexTrackingBackgroundColor   = UIColor.clear
        tableView.sectionIndexBackgroundColor           = UIColor.clear
        tableView.keyboardDismissMode   = .onDrag
        
        /// Add delegates
        searchBar.delegate      = self
        tableView.dataSource    = self
        tableView.delegate      = self
        
        /// Add stackview
        self.view.addSubview(stackView)
        
        //autolayout the stack view and elements
        let viewsDictionary = [
            "stackView" :   stackView
            ] as [String : Any]
        
        //constraint for stackview
        let stackView_H = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[stackView]-0-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: viewsDictionary
        )
        //constraint for stackview
        let stackView_V = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[stackView]-0-|",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil,
            views: viewsDictionary
        )
        
        /// Searchbar constraint
        searchBar.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0).isActive  = true
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive     = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive   = true
        searchBar.heightAnchor.constraint(equalToConstant: CGFloat(40)).isActive            = true
        
        //Add all constraints to view
        view.addConstraints(stackView_H)
        view.addConstraints(stackView_V)
        
        /// Setup controller
        setupCountries()
        
        self.edgesForExtendedLayout = []
        
    }
    
    /// Function for done button
    func done(){
        
        delegate?.countriesViewController(self, didSelectCountries: selectedCountries)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    /// Function for cancel button
    func cancel(){
        
        delegate?.countriesViewControllerDidCancel(self)
        self.dismiss(animated: true, completion: nil)
        
    }

    // MARK: - UISearchBarDelegate
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
        searchForText(searchText)
        tableView.reloadData()
    }


    fileprivate func searchForText(_ text: String) {
        if text.isEmpty {
            filteredCountries = unfilteredCountries
        } else {
            let allCountries: [Country] = Countries.countries.filter { $0.name.range(of: text) != nil }
            filteredCountries = partionedArray(allCountries, usingSelector: #selector(getter: NSFetchedResultsSectionInfo.name))
            filteredCountries.insert([], at: 0) //Empty section for our favorites
        }
        tableView.reloadData()
    }
    
    //MARK: Viewing Countries
    fileprivate func setupCountries() {
        
        unfilteredCountries = partionedArray(Countries.countries, usingSelector: #selector(getter: NSFetchedResultsSectionInfo.name))
        unfilteredCountries.insert(Countries.countriesFromCountryCodes(majorCountryLocaleIdentifiers), at: 0)
        tableView.reloadData()
        
        /// If some countries are selected, scroll to the first
        if let selectedCountry = selectedCountries.first {
            for (index, countries) in unfilteredCountries.enumerated() {
                if let countryIndex = countries.index(of: selectedCountry) {
                    let indexPath = IndexPath(row: countryIndex, section: index)
                    tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    break
                }
            }
        }
    }
    
    //MARK: UItableViewDelegate,UItableViewDataSource

    public func numberOfSections(in tableView: UITableView) -> Int {
        return filteredCountries.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries[section].count
    }
    
    public  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /// Obtain a cell
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
                return UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
            }
            return cell
        }()
        
        /// Configure cell
        let country                 = filteredCountries[indexPath.section][indexPath.row]
        cell.textLabel?.text        = country.name
        cell.detailTextLabel?.text  = "+" + country.phoneExtension
        cell.accessoryType          = (selectedCountries.index(of: country) != nil) ? .checkmark : .none

        return cell
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let countries = filteredCountries[section]
        if countries.isEmpty {
            return nil
        }
        if section == 0 {
            return ""
        }
        return UILocalizedIndexedCollation.current().sectionTitles[section - 1]
    
    }
    
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return searchString != "" ? nil : UILocalizedIndexedCollation.current().sectionTitles
    }
    
    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return UILocalizedIndexedCollation.current().section(forSectionIndexTitle: index + 1)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if allowMultipleSelection {
            if let cell = tableView.cellForRow(at: indexPath){
                if cell.accessoryType == .checkmark{
                    cell.accessoryType = .none
                    let co = filteredCountries[indexPath.section][indexPath.row]
                    selectedCountries = selectedCountries.filter({
                        $0 != co
                    })
                    /// Comunicate to delegate
                    delegate?.countriesViewController(self, didUnselectCountry: co)
                    
                }else{
                    /// Comunicate to delegate
                    delegate?.countriesViewController(self, didSelectCountry: filteredCountries[indexPath.section][indexPath.row])
                    
                    selectedCountries.append(filteredCountries[indexPath.section][indexPath.row])
                    cell.accessoryType = .checkmark
                }
            }
        }else{
            
            /// Comunicate to delegate
            delegate?.countriesViewController(self, didSelectCountry: filteredCountries[indexPath.section][indexPath.row])
            
            self.dismiss(animated: true) { () -> Void in }

        }
        
    }
    
    /// Function to present a selector in a UIViewContoller claass
    ///
    /// - Parameter to: UIViewController current visibile
    public class func Show(countriesViewController co:CountriesViewController, to: UIViewController) {
        
        let navController  = UINavigationController(rootViewController: co)
        
        to.present(navController, animated: true) { () -> Void in }
        
    }
    
}


/// Return partionated array
///
/// - Parameters:
///   - array: source array
///   - selector: selector
/// - Returns: Partionaed array
private func partionedArray<T: AnyObject>(_ array: [T], usingSelector selector: Selector) -> [[T]] {
    
    let collation = UILocalizedIndexedCollation.current()
    let numberOfSectionTitles = collation.sectionTitles.count
    var unsortedSections: [[T]] = Array(repeating: [], count: numberOfSectionTitles)
    
    for object in array {
        let sectionIndex = collation.section(for: object, collationStringSelector: selector)
        unsortedSections[sectionIndex].append(object)
    }
    
    var sortedSections: [[T]] = []
    
    for section in unsortedSections {
        let sortedSection = collation.sortedArray(from: section, collationStringSelector: selector) as! [T]
        sortedSections.append(sortedSection)
    }
    
    return sortedSections

}
