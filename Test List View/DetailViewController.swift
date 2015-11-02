//
//  DetailViewController.swift
//  Test List View
//
//  Created by Alexsander  on 10/30/15.
//  Copyright © 2015 Alexsander Khitev. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    

    var element: Digit!
    
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var colorButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        print(element)
        
        
        let gradient = CAGradientLayer()
        
        gradient.colors = [
            UIColor.greenColor().CGColor,
            UIColor.greenColor().CGColor,
            UIColor.blackColor().CGColor,
            UIColor.blackColor().CGColor
        ]
        gradient.frame.size = colorButton.frame.size
        gradient.locations = [0, element.color!, element.color!, 1]
        gradient.startPoint = CGPointMake(0, 0.5)
        if element.color == 0 {
             gradient.endPoint = CGPointMake(0, 0.5)
        } else {
            gradient.endPoint = CGPointMake(1, 0.5)
        }
        
        
        numberLabel.text = "\(element.number!)"
        colorButton.layer.insertSublayer(gradient, atIndex: 0)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
