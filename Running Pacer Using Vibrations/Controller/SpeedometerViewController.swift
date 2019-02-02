//
//  SpeedometerViewController.swift
//  Running Pacer Using Vibrations
//
//  Created by Sam Guyette on 1/23/19.
//  Copyright © 2019 Sam Guyette. All rights reserved.
//

import UIKit
import CoreLocation


class SpeedometerViewController: UIViewController {

    @IBOutlet weak var goalTime: UILabel!
    var goalMinutePassedOver: String?
    var goalSecondPassedOver: String?
    
    @IBOutlet weak var currentPace: UILabel!        //current pace label
    
    
    private let locationManager = LocationManager.shared
    private var seconds = 0
    private var timer: Timer?       //will fire each second and update the UI accordingly.
    private var distance = Measurement(value: 0, unit: UnitLength.meters)   //holds the cumulative distance of the run.
    private var locationList: [CLLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let completeTime = "Goal time: "+goalMinutePassedOver!+":"+goalSecondPassedOver!
        
        let screenWidth  = UIScreen.main.fixedCoordinateSpace.bounds.width
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        //speedometer gauge
        let test = GaugeView(frame: CGRect(x: (screenHeight * 0.09), y: (screenWidth * 0.35), width: 256, height: 256))      //decleration of Gauge
        test.backgroundColor = .clear
        view.addSubview(test)
        
        startRun()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            UIView.animate(withDuration: 1) {
//                test.value = 33
//            }
//        }
// 
        goalTime.text = completeTime
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        locationManager.stopUpdatingLocation()
    }
    
    func startRun(){
        seconds = 0
        distance = Measurement(value: 0, unit: UnitLength.meters)
        locationList.removeAll()
        updateDisplay()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.eachSecond()
        }
        startLocationUpdates()
    }
    
    
    func eachSecond() {
        seconds += 1
        updateDisplay()
    }
    
    private func updateDisplay() {
        //let formattedDistance = FormatDisplay.distance(distance)
        //let formattedTime = FormatDisplay.time(seconds)
        let formattedPace = FormatDisplay.pace(distance: distance, seconds: seconds, outputUnit: UnitSpeed.minutesPerMile)
        currentPace.text = "Pace:  \(formattedPace)"
        print(formattedPace)
    }
    
    private func startLocationUpdates() {
        locationManager.delegate = self
        locationManager.activityType = .fitness
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
    }
    

    @IBAction func finishRun(_ sender: Any) {
        locationManager.stopUpdatingLocation()
        performSegue(withIdentifier: "goHome", sender: self)
    }
    

}

extension SpeedometerViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for newLocation in locations {
            let howRecent = newLocation.timestamp.timeIntervalSinceNow
            guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }
            
            if let lastLocation = locationList.last {
                let delta = newLocation.distance(from: lastLocation)
                distance = distance + Measurement(value: delta, unit: UnitLength.meters)
            }
            
            locationList.append(newLocation)
        }
    }
}


