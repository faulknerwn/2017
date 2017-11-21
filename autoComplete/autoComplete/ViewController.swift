//
//  ViewController.swift
//  autoComplete
//
//  Created by Wendy Faulkner on 11/16/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate,   UITableViewDataSource {
    
    

    @IBOutlet var countryTableView: UITableView!
    
    @IBOutlet var countryTextField: UITextField!
    var autocompleteCountries = [String]()
    
    // Get list of countries
    let countries = NSLocale.isoCountryCodes.map { (code:String) -> String in
        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        return NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(countries)
        countryTextField.delegate = self
        
        countryTableView.delegate = self
        countryTableView.dataSource = self
        countryTableView.isScrollEnabled = true
        countryTableView.isHidden = true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print("text field has changed")
        countryTableView!.isHidden = false
        
        let substring = (self.countryTextField.text! as NSString).replacingCharacters(in: range, with: string)
        print(substring)
        searchAutocompleteEntriesWithSubstring(substring: substring)
        return true
    }
    
    func searchAutocompleteEntriesWithSubstring(substring: String) {
        autocompleteCountries.removeAll(keepingCapacity: false)
        print(substring)
        
        for curString in countries {
            //print(curString)
            let myString: NSString! = curString.lowercased() as NSString
            let substringRange: NSRange! = myString.range(of: substring.lowercased())
            if (substringRange.location == 0) {
                autocompleteCountries.append(curString)
            }
        }
        
        countryTableView!.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autocompleteCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let autoCompleteRowIdentifier = "AutoCompleteRowIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: autoCompleteRowIdentifier) as UITableViewCell!
        
        if let temp1 = cell {
            let index = indexPath.row as Int
            cell!.textLabel!.text = autocompleteCountries[index]
        }
            
        else {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: autoCompleteRowIdentifier)
        }
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell : UITableViewCell = tableView.cellForRow(at: indexPath)!
        countryTextField.text = selectedCell.textLabel!.text
        countryTableView.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

