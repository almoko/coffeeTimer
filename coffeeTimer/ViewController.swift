//
//  ViewController.swift
//  coffeeTimer
//
//  Created by Alex on 7/31/15.
//  Copyright © 2015 Alex Motrenko. All rights reserved.
//

import UIKit
import AVFoundation

class coffeeTimer {
    var countDownFrom : Int = 25
    var currentCount : Int = 25
    var currentGo : Bool = false
    let maxSec = 40
    let minSec = 0
}

var myTimer = coffeeTimer()

let aSelector : Selector = "minusOneSec"
var theTimer = NSTimer()

func playInputClick() {
    AudioServicesPlaySystemSound(1104)
}

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    // MARK: Actions
    
    @IBAction func moreButton(sender: AnyObject) {
        if myTimer.currentGo == false {
            changeTimer(true)
            playInputClick()
        }
    }
    @IBAction func lessButton(sender: AnyObject) {
        if myTimer.currentGo == false {
            changeTimer(false)
            playInputClick()
        }
    }
    
    @IBAction func startStopButton(sender: AnyObject) {
        theTimer.invalidate()
        myTimer.currentCount = myTimer.countDownFrom
        myTimer.currentGo = false
        updateTimer()
        resetButton.alpha = 0.1
        leftButton.alpha = 1
        rightButton.alpha = 1
    }
    
    @IBOutlet weak var timerDisplay: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBAction func timerLaunch(sender: UITapGestureRecognizer) {
        
        // START THE TIMER
        
        if myTimer.currentGo == false {
            myTimer.currentGo = true
            theTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: aSelector, userInfo: nil, repeats: true)
            resetButton.alpha = 1
            leftButton.alpha = 0.1
            rightButton.alpha = 0.1
            playInputClick()
        }
            
        // STOP THE TIMER
            
        else {
            myTimer.currentGo = false
            theTimer.invalidate()
        }
    }
    
    @IBAction func swipeUp(sender: UIPanGestureRecognizer) {
//        if sender.state == UIGestureRecognizerState.Ended {
//            if sender.translationInView(self.view).y < 0 {
//                changeTimer(true)
//            }
//            if sender.translationInView(self.view).y > 0 {
//                changeTimer(false)
//            }
//        }
    }
   
    // MARK: Functions

    func minusOneSec () {
        
        if myTimer.currentCount > 0 {
            myTimer.currentCount--
            timerDisplay.text = String(myTimer.currentCount)
            
            // Play warning sounds
            
            if myTimer.currentCount < 4 && myTimer.currentCount >= 1 {
                AudioServicesPlaySystemSound(1115)
            }
            
            // Play final sound and change color to red temporarily
            
            if myTimer.currentCount == 0 {
                AudioServicesPlaySystemSound(1116)
                timerDisplay.textColor = UIColor.redColor()
                resetButton.alpha = 0.1
            }
        }
            
        else {
            theTimer.invalidate()
            myTimer.currentCount = myTimer.countDownFrom
            timerDisplay.textColor = UIColor.blackColor()
            updateTimer()
            myTimer.currentGo = false
            leftButton.alpha = 1
            rightButton.alpha = 1
        }
    }
    
    // changeTimer add 1 if up is true
    
    func changeTimer (up: Bool) {
        if up && myTimer.countDownFrom < myTimer.maxSec {
            myTimer.countDownFrom++
            myTimer.currentCount = myTimer.countDownFrom
        }
        if up == false && myTimer.countDownFrom > myTimer.minSec {
            myTimer.countDownFrom--
            myTimer.currentCount = myTimer.countDownFrom
        }
        updateTimer()
    }
    
    // This updates the timer
    
    func updateTimer () {
        timerDisplay.text = String(myTimer.currentCount)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTimer.currentCount = myTimer.countDownFrom
        myTimer.currentGo = false
        updateTimer()
        resetButton.alpha = 0.1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

