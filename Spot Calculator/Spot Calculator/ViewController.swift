//
//  ViewController.swift
//  Spot Calculator
//
//  Created by Wendy Faulkner on 9/5/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    var planeData: [String] = [String]()
    var chosenPlane: String = ""
    var airportData: [String] = [String]()
    
    var webpage = ""
    var chosenPlaneNumber: Int = 0
    var chosenAirport: String = ""
    var chosenAirportNumber: Int = 0
    var airport2: String = ""
    var windgs: String = "0"
    var windgd: String = "0"
    
    var wind3s: String = "0"
    var wind3d: String = "0"
    var wind6s: String = "0"
    var wind6d: String = "0"
    var wind9s: String = "0"
    var wind9d: String = "0"
    var wind12s: String = "0"
    var wind12d: String = "0"
    var convertedDirections: [Int] = [0,0,0,0,0]
    var convertedWindDistance: [Double] = [0,0,0,0,0]
    var vertical: [Double] = [0,0,0,0,0]
    var horizontal: [Double] = [0,0,0,0,0]
    var horTotal: Double = 0
    var verTotal: Double = 0
    var finalAngle: Int = 0
    var jumpRunLength: [Double] = [1.5,0.5,1.3,1.78,1.27]
    var forwardThrow: [Double] =  [0.15,0.10,0.18,0.15,0.15]
    var displacement: Double = 0.0
    var spotWords: String = ""
    var activityIndicator = UIActivityIndicatorView()
    
    let websites = ["alaska": ["ADK","ADQ","AKN","ANC","ANN","BET","BRW","BTI","BTT","CDB","CZF","EHM","FAI","FYU","GAL","GKN","HOM","JNU","LUR","MCG","MDO","OME","OTZ","SNP","TKA","UNK","YAK","IKO","AFM","5AB","5AC","5AD","5AE","5AF","5AG"], "bos": ["BDL","BGR","CAR","PWM","EMI","ACK","BOS","BML","ACY","ALB","BUF","JFK","PLB","SYR","CLE","CMH","CVG","AGC","AVP","ORF","RIC","ROA","CRW"], "chi": ["BRL","DBQ","DSM","MCW","JOT","SPI","EVV","FWA","IND","ICT","SLN","LOU","ECK","MKG","MQT","SSM","TVC","AXN","DLH","INL","MSP","CGI","COU","MKC","SGF","STL","GFK","OMA","ABR","FSD","GRB","LSE"], "dfw": ["BHM","HSV","MGM","MOB","FSM","LIT","LCH","MSY","SHV","JAN","OKC","TUL","BNA","MEM","TYS","BRO","CLL","CRP","DAL","DRT","HOU","LRD","PSX","SAT","SPS","T01","T06","T07","4J3","H51","H52","H61"], "hawaii": ["LIH","HNL","OGG","KOA","ITO"], "mia": ["EYW","JAX","MIA","MLB","PFN","PIE","TLH","ATL","CSG","SAV","HAT","ILM","RDU","CAE","CHS","FLO","GSP","2XG"], "other_pac":  ["JON","KWA","MAJ","MDY","PPG","TTK","AWK","GRO","GSN","TNI","GUM","TKK","PNI","ROR","T11"], "sfo": ["BIH","BLH","FAT","FOT","ONT","RBL","SAC","SAN","SBA","SFO","AST","OTH","PDX","SEA","YKM"], "slc": ["LWS","PHX"] ]
    
    @IBOutlet var airport: UIPickerView!
    @IBOutlet var airplane: UIPickerView!
    
    @IBOutlet var ownWinds: UISwitch!
    
    
    @IBOutlet var w12: UITextField!
    @IBOutlet var d12: UITextField!
    
    @IBOutlet var w9: UITextField!
    @IBOutlet var d9: UITextField!
    
    @IBOutlet var w6: UITextField!
    @IBOutlet var d6: UITextField!
    
    @IBOutlet var d3: UITextField!
    @IBOutlet var w3: UITextField!
    
    @IBOutlet var wg: UITextField!
    
    @IBOutlet var dg: UITextField!
    @IBOutlet var calculateSpotButton: UIButton!
    @IBOutlet var spot: UILabel!
    
    @IBAction func infoClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "App Info", message: "Choose Airplane Type, and Default Winds Aloft Location. \n If You Wish To Enter Your Own Winds Aloft Information, Change Switch To On. \nClick Compute Spot to Get Ideal Spot.", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            print("button pressed")
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        
        self.present(alertController, animated: true, completion: nil) //display it
    }
    func getWinds() {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        activityIndicator.center = self.view.center
        
        activityIndicator.hidesWhenStopped = true
        
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        for site in  ["alaska", "bos", "chi", "dfw", "hawaii", "mia", "other_pac", "sfo", "slc"] {
            
            for airport in websites[site]! {
                if airport == chosenAirport {
                    webpage = site.lowercased()
                }
            }
        }
        
        let mainURL = URL(string: "https://aviationweather.gov/windtemp/data?region=" + webpage)!
        
        var message = ""
        let request = NSMutableURLRequest(url: mainURL)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print(error ?? 0 )
                
                
            } else {
                if let unwrappedData = data {
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    if let contentArray = dataString?.components(separatedBy: self.chosenAirport) {
                        if contentArray.count > 0  {
                            let stringSeparator = "\n"
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                            
                            if newContentArray.count > 0 {
                                message = newContentArray[0]
                                
                            } //if
                        } //if
                    } //if
                } //if
                
            } //else
            
            var windsArray = message.components(separatedBy: " ")
            var winds3 = windsArray[1]
            var winds6 = windsArray[2]
            var winds9 = windsArray[3]
            var winds12 = windsArray[4]
            
            var temporary = winds3.components(separatedBy: "+")
            var temporary2 = temporary[0].components(separatedBy: "-")
            winds3 = temporary2[0]
            temporary = winds6.components(separatedBy: "+")
            
            var strIndex = winds3.index(winds3.startIndex, offsetBy: 2)
            //var wind3d = winds3.substring(to: strIndex) + "0"
            //var wind3s = winds3.substring(from: strIndex)
            self.wind3s = String(winds3.suffix(2))
            self.wind3d = String(winds3[..<strIndex]) + "0"
            
            
            temporary = winds6.components(separatedBy: "+")
            temporary2 = temporary[0].components(separatedBy: "-")
            winds6 = temporary2[0]
            
            strIndex = winds6.index(winds6.startIndex, offsetBy: 2)
            self.wind6s = String(winds6.suffix(2))
            self.wind6d = String(winds6[..<strIndex]) + "0"
            //var wind6d = winds6.substring(to: strIndex) + "0"
            //var wind6s = winds6.substring(from: strIndex)
            
            temporary = winds9.components(separatedBy: "+")
            temporary2 = temporary[0].components(separatedBy: "-")
            winds9 = temporary2[0]
            strIndex = winds9.index(winds9.startIndex, offsetBy: 2)
            self.wind9s = String(winds9.suffix(2))
            self.wind9d = String(winds9[..<strIndex]) + "0"
            //var wind9d = winds9.substring(to: strIndex) + "0"
            //var wind9s = winds9.substring(from: strIndex)
            
            temporary = winds12.components(separatedBy: "+")
            temporary2 = temporary[0].components(separatedBy: "-")
            winds12 = temporary2[0]
            strIndex = winds12.index(winds12.startIndex, offsetBy: 2)
            self.wind12s = String(winds12.suffix(2))
            self.wind12d = String(winds12[..<strIndex]) + "0"
            //var wind12d = winds12.substring(to: strIndex) + "0"
            //var wind12s = winds12.substring(from: strIndex)
            
            DispatchQueue.main.sync(execute: {
                self.w3.text = self.wind3s
                self.d3.text = self.wind3d
                self.w6.text = self.wind6s
                self.d6.text = self.wind6d
                self.w9.text = self.wind9s
                self.d9.text = self.wind9d
                self.w12.text = self.wind12s
                self.d12.text = self.wind12d
                
            })
            
        }
        
        task.resume()
        activityIndicator.stopAnimating()
    }
    
    
    
    @IBAction func calculate(_ sender: Any) {
        
        
        UserDefaults.standard.set(chosenPlane, forKey: "Plane")
        UserDefaults.standard.set(chosenPlaneNumber, forKey: "PlaneNumber")
        UserDefaults.standard.set(chosenAirportNumber, forKey: "AirportNumber")
        UserDefaults.standard.set(chosenAirport, forKey: "Airport")
        
        if !ownWinds.isOn {
            
            getWinds()
        }
        else {
            wind3s=w3.text!
            wind3d=d3.text!
            wind6s=w6.text!
            wind6d=d6.text!
            wind9s=w6.text!
            wind9d=d9.text!
            wind12s=w12.text!
            wind12d=d12.text!
        }
        convertedDirections[0] = Int(dg.text!)!
        convertedDirections[1] = Int(wind3d)!
        convertedDirections[2] = Int(wind6d)!
        convertedDirections[3] = Int(wind9d)!
        convertedDirections[4] = Int(wind12d)!
        
        
        convertedWindDistance[0] = Double(wg.text!)! * 1.15 / 60
        convertedWindDistance[1] = Double(wind3s)! * 1.15 * 1.5 / 60
        convertedWindDistance[2] = Double(wind6s)! * 1.15 / 240
        convertedWindDistance[3] = Double(wind9s)! * 1.15 / 240
        convertedWindDistance[4] = Double(wind12s)! * 1.15 / 240
        
        print("WindDistance",convertedWindDistance[0],convertedWindDistance[1],convertedWindDistance[2],convertedWindDistance[3],convertedWindDistance[4])
        
        print("WindDirection",convertedDirections[0],convertedDirections[1],convertedDirections[2],convertedDirections[3],convertedDirections[4] )
        
        var i = 0
        var convertedAngle = 0
        verTotal = 0
        horTotal = 0
        //var h: Double = 1
        //var v: Double = 1
        
        while i < 5 {
            /*if convertedDirections[i] == 990 {
             convertedDirections[i] = 0
             }
             
             convertedDirections[i] = 90 - convertedDirections[i]
             
             if convertedDirections[i] < 0 {
             convertedDirections[i] = 360 + convertedDirections[i]
             }
             if convertedDirections[i] > 90 && convertedDirections[i] < 180 {
             convertedDirections[i] = 180 - convertedDirections[i]
             h = -1
             }
             if convertedDirections[i] > 180 && convertedDirections[i] < 270 {
             convertedDirections[i] = convertedDirections[i] - 180
             v = -1
             h = -1
             }
             if convertedDirections[i] > 270 && convertedDirections[i] < 360 {
             convertedDirections[i] = 360 - convertedDirections[i]
             v = -1
             } */
            
            if convertedDirections[i] == 990 {
                convertedDirections[i] = 0
            }
            if convertedDirections[i] == 360 {
                convertedDirections[i] = 0
            }
            if convertedDirections[i] == 0 {
                vertical[i] = Double(convertedWindDistance[i])
                horizontal[i] = 0
            }
            if convertedDirections[i] == 90 {
                horizontal[i] = Double(convertedWindDistance[i])
                vertical[i] = 0
            }
            if convertedDirections[i] == 180 {
                vertical[i] = Double(convertedWindDistance[i]) * -1
                horizontal[i] = 0
            }
            if convertedDirections[i] == 270 {
                horizontal[i] = Double(convertedWindDistance[i]) * -1
                vertical[i] = 0
            }
            if 0 < convertedDirections[i] && convertedDirections[i] < 90 {
                vertical[i] = cos((Double(convertedDirections[i]) * 3.14 / 180) ) * Double(convertedWindDistance[i])
                horizontal[i] = sin((Double(convertedDirections[i]) * 3.14 / 180) ) * Double(convertedWindDistance[i])
            }
            if 90 < convertedDirections[i] && convertedDirections[i] < 180 {
                convertedAngle = 180 - convertedDirections[i]
                print("CA",convertedAngle)
                vertical[i] = cos((Double(convertedAngle) * 3.14 / 180) ) * Double(convertedWindDistance[i]) * -1
                horizontal[i] = sin((Double(convertedAngle) * 3.14 / 180) ) * Double(convertedWindDistance[i])
            }
            if 180 < convertedDirections[i] && convertedDirections[i] < 270 {
                convertedAngle = convertedDirections[i] - 180
                print("CA",convertedAngle)
                vertical[i] = cos((Double(convertedAngle) * 3.14 / 180) ) * Double(convertedWindDistance[i]) * -1
                horizontal[i] = sin((Double(convertedAngle) * 3.14 / 180) ) * Double(convertedWindDistance[i]) * -1
            }
            if 270 < convertedDirections[i] && convertedDirections[i] < 360 {
                convertedAngle = 360 - convertedDirections[i]
                print("CA",convertedAngle)
                vertical[i] = cos((Double(convertedAngle) * 3.14 / 180) ) * Double(convertedWindDistance[i])
                horizontal[i] = sin((Double(convertedAngle) * 3.14 / 180) ) * Double(convertedWindDistance[i]) * -1
            }
            //vertical[i] = sin((Double(convertedDirections[i]) * 3.14 / 180) ) * Double(convertedWindDistance[i]) * v
            // horizontal[i] = cos((Double(convertedDirections[i]) * 3.14 / 180) ) * Double(convertedWindDistance[i]) * h
            
            if chosenPlane == "Cessna 182" {
                vertical[4] = 0
                horizontal[4] = 0
                print("cessna")
            }
            verTotal = verTotal + vertical[i]
            horTotal = horTotal + horizontal[i]
            print ("vertical", vertical[i],"hor",horizontal[i], "VT",verTotal, "HT",horTotal)
            i = i+1
            
            
            
        }
        
        
        displacement = sqrt(verTotal*verTotal + horTotal*horTotal)
        print ("displacement", displacement)
        finalAngle = (Int(atan(abs(horTotal/verTotal)) * 180 / 3.14))
        print(finalAngle)
        
        /*if finalAngle < 0 {
         finalAngle = 0 - finalAngle
         }*/
        
        if horTotal < 0 && verTotal > 0 {
            finalAngle = 360 - finalAngle
        }
        if horTotal < 0 && verTotal < 0 {
            finalAngle =  finalAngle + 180
        }
        if horTotal > 0 && verTotal < 0 {
            finalAngle = 180 - finalAngle
        }
       /* if horTotal > 0 && verTotal > 0 {
            finalAngle =  90 - finalAngle
        }*/
        print(finalAngle)
        finalAngle = Int(10 * (Double(finalAngle/10).rounded()))
         print(finalAngle)
        print("JR", jumpRunLength[chosenPlaneNumber]/2, "FT", forwardThrow[chosenPlaneNumber] )
        var greenLight = (displacement - jumpRunLength[chosenPlaneNumber]/3 - forwardThrow[chosenPlaneNumber])
        greenLight = (greenLight*10).rounded() / 10
       
        var finalA = String(finalAngle)
        
        if finalA.characters.count == 1 {
            finalA = "00" + finalA
        }
        if finalA.characters.count == 2 {
            finalA = "0" + finalA
        }
        spotWords = "Spot: Green Light at " + String(greenLight) + " heading " + finalA
        
        spot.text = spotWords
        
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
            if !ownWinds.isOn {
                getWinds()
            }
        }
    }
    @objc func doneClicked() {
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wg.delegate = self
        dg.delegate = self
        
        // add done button to keyboard
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target:nil, action:nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolBar.setItems([flexibleSpace,doneButton], animated: false)
        
        wg.inputAccessoryView = toolBar
        dg.inputAccessoryView = toolBar
        w3.inputAccessoryView = toolBar
        d3.inputAccessoryView = toolBar
        w6.inputAccessoryView = toolBar
        d6.inputAccessoryView = toolBar
        w9.inputAccessoryView = toolBar
        d9.inputAccessoryView = toolBar
        w12.inputAccessoryView = toolBar
        d12.inputAccessoryView = toolBar
        
        self.airplane.delegate = self
        self.airplane.dataSource = self
        self.airport.delegate = self
        self.airport.dataSource = self
        airportData = ["2XG","4J3","5AB","5AC","5AD","5AE","5AF","5AG","ABR","ACK","ACY","ADK","ADQ","AFM","AGC","AKN","ALB","ANC","ANN","AST","ATL","AVP","AWK","AXN","BDL","BET","BGR","BHM","BIH","BLH","BML","BNA","BOS","BRL","BRO","BRW","BTI","BTT","BUF","CAE","CAR","CDB","CGI","CHS","CLE","CLL","CMH","COU","CRP","CRW","CSG","CVG","CZF","DAL","DBQ","DLH","DRT","DSM","ECK","EHM","EMI","EVV","EYW","FAI","FAT","FLO","FOT","FSD","FSM","FWA","FYU","GAL","GFK","GKN","GRB","GRO","GSN","GSP","GUM","H51","H52","H61","HAT","HNL","HOM","HOU","HSV","ICT","IKO","ILM","IND","INL","ITO","JAN","JAX","JFK","JNU","JON","JOT","KOA","KWA","LCH","LIH","LIT","LOU","LRD","LSE","LUR","LWS","MAJ","MCG","MCW","MDO","MDY","MEM","MGM","MIA","MKC","MKG","MLB","MOB","MQT","MSP","MSY","OGG","OKC","OMA","OME","ONT","ORF","OTH","OTZ","PDX","PFN","PHX","PIE","PLB","PNI","PPG","PSX","PWM","RBL","RDU","RIC","ROA","ROR","SAC","SAN","SAT","SAV","SBA","SEA","SFO","SGF","SHV","SLN","SNP","SPI","SPS","SSM","STL","SYR","T01","T06","T07","T11","TKA","TKK","TLH","TNI","TTK","TUL","TVC","TYS","UNK","YAK","YKM"]
        
        planeData = ["Caravan", "Cessna 182", "King Air", "Otter", "Pac 750"]
        
        
        
        
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
        
        getWinds()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

