//
//  SpeedometerViewController.swift
//  Running Pacer Using Vibrations
//
//  Created by Sam Guyette on 1/23/19.
//  Copyright © 2019 Sam Guyette. All rights reserved.
//

import UIKit

class SpeedometerViewController: UIViewController {

    @IBOutlet weak var goalTime: UILabel!
    var goalMinutePassedOver: String?
    var goalSecondPassedOver: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let completeTime = "Goal time: "+goalMinutePassedOver!+":"+goalSecondPassedOver!
        
        goalTime.text = completeTime
    }
    

    @IBAction func finishRun(_ sender: Any) {
    
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
