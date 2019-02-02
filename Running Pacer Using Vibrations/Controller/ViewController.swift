//
//  ViewController.swift
//  Running Pacer Using Vibrations
//
//  Created by Sam Guyette on 1/23/19.
//  Copyright © 2019 Sam Guyette. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBOutlet weak var goalMinute: UITextField!
    @IBOutlet weak var goalSecond: UITextField!
    
    
    @IBAction func startMyRunBtn(_ sender: Any) {
        //let goalTime = [goalMinute.text, goalSecond.text]
        performSegue(withIdentifier: "goToSpeedometer", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSpeedometer" {
            let destinationVC = segue.destination as! SpeedometerViewController
            destinationVC.goalMinutePassedOver = goalMinute.text!
            destinationVC.goalSecondPassedOver = goalSecond.text!
        }
    }

}

