//
//  ViewController.swift
//  Spot Calculator
//
//  Created by Wendy Faulkner on 9/5/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var planeData: [String] = [String]()
    var chosenPlane: String = ""
    var airportData: [String] = [String]()
    var alaska: [String] = [String]()
    var bos: [String] = [String]()
    var chi: [String] = [String]()
    var dfw: [String] = [String]()
    var hawaii: [String] = [String]()
    var mia: [String] = [String]()
    var other_pac: [String] = [String]()
    var sfo: [String] = [String]()
    var slc: [String] = [String]()
    
    var chosenPlaneNumber: Int = 0
    var chosenAirport: String = ""
    var chosenAirportNumber: Int = 0
    

    @IBOutlet var airport: UIPickerView!
    @IBOutlet var airplane: UIPickerView!
    
    @IBOutlet var w12: UITextField!
    
    @IBOutlet var w9: UITextField!
    
    @IBOutlet var w6: UITextField!
    
    @IBOutlet var w3: UITextField!
    
    @IBOutlet var wg: UITextField!
    
    
    @IBOutlet var d12: UITextField!
    
    @IBOutlet var d9: UITextField!
    
    @IBOutlet var d6: UITextField!
    
    @IBOutlet var d3: UITextField!
    
    @IBOutlet var dg: UITextField!
    
    @IBOutlet var calculateSpotButton: UIButton!
    @IBOutlet var spot: UILabel!
    
    @IBAction func calculate(_ sender: Any) {
        
        //print("hello", airport, chosenPlane)
        UserDefaults.standard.set(chosenPlane, forKey: "Plane")
        UserDefaults.standard.set(chosenPlaneNumber, forKey: "PlaneNumber")
        UserDefaults.standard.set(chosenAirportNumber, forKey: "AirportNumber")
        UserDefaults.standard.set(chosenAirport, forKey: "Airport")
        print(chosenAirportNumber, chosenAirport, chosenPlaneNumber, chosenPlane)
        
        
        
        let mainURL = URL(string: "https://aviationweather.gov/windtemp/data?region=dfw")!
        let location = "CLL"
        var message = ""
        let request = NSMutableURLRequest(url: mainURL)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
        data, response, error in
            if error != nil {
                print(error)
                
            } else {
                if let unwrappedData = data {
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    if let contentArray = dataString?.components(separatedBy: location) {
                        if contentArray.count > 0  {
                            var stringSeparator = "\n"
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                                if newContentArray.count > 0 {
                                    message = newContentArray[0]
                                    print(newContentArray[0])
                                }
                        }
                }
            }
            
        }
        }
        task.resume()
        
        
    } //calculate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }


    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 2) {
            return planeData.count
        } else {
            return airportData.count
        }
    }
    
        // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 2) {
            return planeData[row]
        }
        else {
            return airportData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 2) {
            chosenPlane = planeData[row] as String
            chosenPlaneNumber = row
        }
        else {
            chosenAirport = airportData[row] as String
            chosenAirportNumber = row
        }
        
    }
    
    // The data to return for the row and component (column) that's being passed in
    
    
    // Capture the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        if (pickerView.tag == 2) {
            chosenPlaneNumber = row
            chosenPlane = planeData[row]
            UserDefaults.standard.set(chosenPlane, forKey: "Plane")
            UserDefaults.standard.set(chosenPlaneNumber, forKey: "PlaneNumber")
        } else {
            chosenAirport = airportData[row] as String
            chosenAirportNumber = row
            UserDefaults.standard.set(chosenAirport, forKey: "Airport")
            UserDefaults.standard.set(chosenAirportNumber, forKey: "AirportNumber")
        }
    }
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.airplane.delegate = self
        self.airplane.dataSource = self
        self.airport.delegate = self
        self.airport.dataSource = self
         airportData = ["2XG","4J3","5AB","5AC","5AD","5AE","5AF","5AG","ABI","ABQ","ABR","ACK","ACY","ADK","ADQ","AFM","AGC","AKN","ALB","ALS","AMA","ANC","ANN","AST","ATL","AVP","AWK","AXN","BAM","BCE","BDL","BET","BFF","BGR","BHM","BIH","BIL","BLH","BML","BNA","BOI","BOS","BRL","BRO","BRW","BTI","BTT","BUF","CAE","CAR","CDB","CGI","CHS","CLE","CLL","CMH","COU","CRP","CRW","CSG","CVG","CZF","CZI","DAL","DBQ","DEN","DIK","DLH","DLN","DRT","DSM","ECK","EHM","EKN","ELP","ELY","EMI","EVV","EYW","FAI","FAT","FLO","FMN","FOT","FSD","FSM","FWA","FYU","GAG","GAL","GCK","GEG","GFK","GGW","GJT","GKN","GLD","GPI","GRB","GRI","GRO","GSN","GSP","GTF","GUM","H51","H52","H61","HAT","HNL","HOM","HOU","HSV","ICT","IKO","ILM","IMB","IND","INK","INL","ITO","JAN","JAX","JFK","JNU","JON","JOT","KOA","KWA","LAS","LBB","LCH","LIH","LIT","LKV","LND","LNY","LOU","LRD","LSE","LUR","LWS","MAJ","MBW","MCG","MCW","MDO","MDY","MEM","MGM","MIA","MKC","MKG","MLB","MLS","MOB","MOT","MQT","MRF","MSP","MSY","OGG","OKC","OMA","OME","ONL","ONT","ORF","ORT","OTH","OTZ","PDX","PFN","PHX","PIE","PIH","PIR","PLB","PNI","PPG","PRC","PSB","PSX","PUB","PWM","RAP","RBL","RDM","RDU","RIC","RKS","RNO","ROA","ROR","ROW","SAC","SAN","SAT","SAV","SBA","SEA","SFO","SGF","SHV","SIY","SLC","SLN","SNP","SPI","SPS","SSM","STL","SYR","T01","T06","T07","T11","TCC","TKA","TKK","TLH","TNI","TRI","TTK","TUL","TUS","TVC","TYS","UNK","WJF","YAK","YKM","ZUN"]
        
         planeData = ["Caravan", "Cessna 182", "King Air", "Otter", "Pac 750"]
        
        alaska = ["ADK","ADQ","AKN","ANC","ANN","BET","BRW","BTI","BTT","CDB","CZF","EHM","FAI","FYU","GAL","GKN","HOM","JNU","LUR","MCG","MDO","OME","ORT","OTZ","SNP","TKA","UNK","YAK","IKO","AFM","5AB","5AC","5AD","5AE","5AF","5AG"]
        bos = ["2519","CAR","PWM","EMI","ACK","BOS","BML","ACY","ALB","BUF","JFK","PLB","SYR","CLE","CMH","CVG","AGC","AVP","PSB","ORF","RIC","ROA","CRW","EKN"]
        chi = ["BRL","DBQ","DSM","MCW","JOT","SPI","EVV","FWA","IND","GCK","GLD","ICT","SLN","LOU","ECK","MKG","MQT","SSM","TVC","AXN","DLH","INL","MSP","CGI","COU","MKC","SGF","STL","DIK","GFK","MOT","BFF","GRI","OMA","ONL","ABR","FSD","PIR","RAP","GRB","LSE"]
        dfw = ["BHM","HSV","MGM","MOB","FSM","LIT","LCH","MSY","SHV","JAN","GAG","OKC","TUL","BNA","MEM","TRI","TYS","ABI","AMA","BRO","CLL","CRP","DAL","DRT","ELP","HOU","INK","LBB","LRD","MRF","PSX","SAT","SPS","T01","T06","T07","4J3","H51","H52","H61"]
        hawaii = ["LIH","HNL","LNY","OGG","KOA","ITO"]
        mia = ["EYW","JAX","MIA","MLB","PFN","PIE","TLH","ATL","CSG","SAV","HAT","ILM","RDU","CAE","CHS","FLO","GSP","2XG"]
        other_pac = ["JON","KWA","MAJ","MDY","PPG","TTK","AWK","GRO","GSN","TNI","GUM","TKK","PNI","ROR","T11"]
        sfo = ["BIH","BLH","FAT","FOT","ONT","RBL","SAC","SAN","SBA","SFO","SIY","WJF","AST","IMB","LKV","OTH","PDX","RDM","GEG","SEA","YKM"]
        slc = ["PHX","PRC","TUS","ALS","DEN","GJT","PUB","BOI","LWS","PIH","BIL","DLN","GGW","GPI","GTF","MLS","BAM","ELY","LAS","RNO","ABQ","FMN","ROW","TCC","ZUN","BCE","SLC","CZI","LND","MBW","RKS"]
            
        if (UserDefaults.standard.object(forKey: "Plane") != nil) {
            chosenPlane = UserDefaults.standard.object(forKey: "Plane") as! String
            chosenPlaneNumber = UserDefaults.standard.object(forKey: "PlaneNumber") as! Int
            airplane.selectRow(chosenPlaneNumber, inComponent: 0, animated: false)
        }
        else {
            chosenPlane = planeData[0]
            UserDefaults.standard.set(chosenPlane, forKey: "Plane")
            UserDefaults.standard.set(0, forKey: "PlaneNumber")
        }
       
        if (UserDefaults.standard.object(forKey: "Airport") != nil) {
            chosenAirport = UserDefaults.standard.object(forKey: "Airport") as! String
            chosenAirportNumber = UserDefaults.standard.object(forKey: "AirportNumber") as! Int
            airport.selectRow(chosenAirportNumber, inComponent: 0, animated: false)
        }
        else {
             chosenAirport = "CLL"
            UserDefaults.standard.set(chosenAirport, forKey: "Airport")
             UserDefaults.standard.set(54, forKey: "AirportNumber")
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

