//
//  ViewController.swift
//  Calcraft
//
//  Created by Dulio Denis on 10/30/15.
//  Copyright © 2015 Dulio Denis. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "x"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLabel: UILabel!
    var buttonSound: AVAudioPlayer!
    
    var currentDisplay = ""
    var leftValueString = ""
    var rightValueString = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    
    // MARK: View Lifecyle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
            buttonSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    // MARK: Calculator Action Operations
    
    @IBAction func clearTapped(sender: AnyObject) {
        playSound()
        currentDisplay = ""
        leftValueString = ""
        rightValueString = ""
        currentOperation = Operation.Empty
        result = ""
        outputLabel.text = "0"
    }
    
    
    @IBAction func numberPressed(button: UIButton!) {
        playSound()
        
        currentDisplay += "\(button.tag)"
        outputLabel.text = currentDisplay
    }
    
    
    @IBAction func onDivideTapped(sender: AnyObject) {
        processOperation(Operation.Divide)
    }

    @IBAction func onMultiplyTapped(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractTapped(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }

    @IBAction func onAddTapped(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualsTapped(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            
            // check to see that the user didn't selected multiple operators in a row
            if currentDisplay != "" {
                rightValueString = currentDisplay
                currentDisplay = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValueString)! * Double(rightValueString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValueString)! / Double(rightValueString)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValueString)! + Double(rightValueString)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValueString)! - Double(rightValueString)!)"
                }
                
                leftValueString = result
                outputLabel.text = result
            }
            
            currentOperation = op
            
        } else { // this is the first time an operation has been tapped
            leftValueString = currentDisplay
            currentDisplay = ""
            currentOperation = op
        }
    }
    
    
    func playSound() {
        if buttonSound.playing {
            buttonSound.stop()
        }
        buttonSound.play()
        
    }

}

