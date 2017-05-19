//
//  MainViewController.swift
//  Hw-3
//
//  Created by Sahana on 5/18/17.
//  Copyright © 2017 Sahana. All rights reserved.
//

import UIKit
protocol SettingsViewControllerDelegate {
    
   func settingsChanged(distanceUnits: String, bearingUnits: String)
   
}


class MainViewController: UIViewController{


    @IBOutlet weak var bearing: UILabel!
    @IBOutlet weak var distance: UILabel!
     @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var distanceUnits: UILabel!
    @IBOutlet weak var bearingUnits: UILabel!
    var selection:UILabel!

    var pickerData : [String] = [String]()
    //var Selection : [String] = ["miles"]
    var delegate : SettingsViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        let gest = UITapGestureRecognizer(target: self, action: #selector(self.displayDistanceUnits))
        let gest1 = UITapGestureRecognizer(target: self, action: #selector(self.displayBearingUnits))
        self.distanceUnits.addGestureRecognizer(gest)
        self.bearingUnits.addGestureRecognizer(gest1)
        picker.delegate = self
        picker.dataSource = self
        pickerData = ["kilometers, miles","degrees, mils"]
        
       

        // Do any additional setup after loading the view.
    }
    func displayDistanceUnits(){
       print("distance")
        self.pickerData = ["Kilometers","Miles"]
        self.picker.isHidden=false
        self.picker.reloadAllComponents()
        self.selection=self.distanceUnits
    }
    func displayBearingUnits(){
        print("bearing")
        self.pickerData = ["Degrees","Mils"]
        self.picker.isHidden=false
        self.picker.reloadAllComponents()
        self.selection=self.bearingUnits

    }
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if let del = self.delegate {
            del.settingsChanged(distanceUnits: self.distanceUnits.text!, bearingUnits: self.bearingUnits.text!)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
//extension MainViewController : UIPickerViewDataSource,UIPickerViewDelegate{
    
    // The number of columns of data
    //func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        //return 1


   // }

    extension MainViewController : UIPickerViewDataSource, UIPickerViewDelegate {
        // The number of columns of data
        func numberOfComponents(in: UIPickerView) -> Int
        {
            return 1
        }
        
        // The number of rows of data
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
        {
            return pickerData.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
        {
            return self.pickerData[row]
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
        {
            self.selection.text = self.pickerData[row]
        }
        
        
        
        
}

