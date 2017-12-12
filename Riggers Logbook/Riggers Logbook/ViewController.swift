//
//  ViewController.swift
//  Riggers Logbook
//
//  Created by Wendy Faulkner on 11/20/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import SearchTextField
import DLRadioButton
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var entries: [Entry] = []
    
    @IBOutlet var logbook: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("entries", entries.count)
        return entries.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let entry = entries[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        //tableView.isScrollEnabled = true
        cell.textLabel?.text = entry.name
        cell.detailTextLabel?.numberOfLines = 0; // 0 means 'no limit'
        logbook.rowHeight = UITableViewAutomaticDimension
        logbook.estimatedRowHeight = 144
        logbook.contentSize.height = 2000
      
        if entry.date != nil {
            
            //let done = entry.date! as Date
            
            
            let doneDateString = dateFormatter.string(from: entry.date! as Date)
            
            
            
            cell.textLabel?.text = entry.name! + " " + doneDateString
            
       }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let entry = entries[indexPath.row]
        
        performSegue(withIdentifier: "addSegue", sender: entry)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextVC = segue.destination as! AddEntryViewController
        nextVC.entry = sender as? Entry
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            
            let entry = entries[indexPath.row]
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            
            context.delete(entry)
            appDelegate.saveContext()
            entries.remove(at: indexPath.row)
            logbook.deleteRows(at: [indexPath], with: .fade)
            logbook.reloadData()
            
        }
    }
    
    private func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: IndexPath!) -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.logbook.delegate = self
        self.logbook.dataSource = self
        
        DispatchQueue.main.async {
            self.logbook.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshUI() {
        DispatchQueue.main.async {
            self.logbook.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            
            entries = try context.fetch(Entry.fetchRequest())
            DispatchQueue.main.async {
                 self.logbook.reloadData()
            }
            refreshUI()
            
         
        } catch {
            
        }
  
        
       
        }
        
   
}

