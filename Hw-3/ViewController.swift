//
//  ViewController.swift
//  Hw-3
//
//  Created by Sahana on 5/18/17.
//  Copyright © 2017 Sahana. All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController, SettingsViewControllerDelegate,CLLocationManagerDelegate {
    
    
    //MARK: Properties
    
    
    @IBOutlet weak var ds: UILabel!
    @IBOutlet weak var br: UILabel!
    @IBOutlet weak var p2longitude: DecimalMinusTextField!
    @IBOutlet weak var p2latitude: DecimalMinusTextField!
    @IBOutlet weak var p1latitude: DecimalMinusTextField!
    @IBOutlet weak var p1longitude: DecimalMinusTextField!
    
    let manager = CLLocationManager()
    @IBOutlet weak var bearing: UILabel!
    @IBOutlet weak var distance: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Do any additional setup after loading the view, typically from a nib.
        let detectTouch = UITapGestureRecognizer(target: self, action:
            #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(detectTouch)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self

    }
    
    func distance(lat1: Double, long1: Double, lat2: Double, long2: Double) -> Double {
        let loc1 = CLLocation(latitude: lat1, longitude: long1)
        let loc2 = CLLocation(latitude: lat2, longitude: long2)
        
        var dist = loc1.distance(from: loc2)
        dist = dist/1000
        return dist
        
    }
    
    func bearing(lat1: Double, long1: Double, lat2: Double, long2: Double) -> Double {
        let x = sin((long2-long1)) * cos(lat2)
        let y = (cos(lat1) * sin(lat2)) - (sin(lat1) * cos(lat2) * cos((long2-long1)))
        
        
        let val_atan = atan2(x,y)
        let bearing1 = val_atan * 180.0 / .pi
        return bearing1
    }
    
    
    @IBAction func calculate(_ sender: UIButton) {
        guard let lat1 = Double(p1latitude.text!) else {return}
        guard let long1 = Double(p1longitude.text!) else {return}
        guard let lat2 = Double(p2latitude.text!) else {return}
        guard let long2 = Double(p2longitude.text!) else {return}
        
        
        var call_dist = distance(lat1: lat1, long1: long1, lat2: lat2, long2: long2)
        var call_bear = bearing(lat1: lat1, long1: long1, lat2: lat2, long2: long2)
        
        
            ds.text = (String)(format: "%.2f", call_dist) + " Kilometers"
            br.text = (String)(format: "%.2f", call_bear) + " Degrees"
        
        
        
        
}
    @IBAction func clear(_ sender: UIButton) {
        p2longitude.text = ""
        p2latitude.text = ""
        p1latitude.text = ""
        p1longitude.text = ""
        ds.text = ""
        br.text = ""
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func settings(_ sender: UIButton) {
    }
    
    func settingsChanged(distanceUnits: String, bearingUnits: String) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToMain" {
            
            if let destNav = segue.destination as? UINavigationController {
                if let dest = destNav.childViewControllers[0] as? MainViewController {
                    dest.delegate = self
                }
            }
        }
    }
    
}
