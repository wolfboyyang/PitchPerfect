//
//  ViewController.swift
//  ClickCounter
//
//  Created by Wei Yang on 6/6/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var count = 0
    @IBOutlet var label: UILabel!
    var label2: UILabel!
    
    var backgroundToggled = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Label
//        var label = UILabel()
//        label.frame = CGRectMake(150, 150, 60, 60)
//        label.text = "0"
//        
//        self.view.addSubview(label)
//        self.label = label
//        
//        //Label2
//        var label2 = UILabel()
//        label2.frame = CGRectMake(200, 150, 60, 60)
//        label2.text = "0"
//        
//        self.view.addSubview(label2)
//        self.label2 = label2
//        
//        //Button
//        var button = UIButton()
//        button.frame = CGRectMake(150, 250, 60, 60)
//        button.setTitle("Click", forState: .Normal)
//        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
//        
//        self.view.addSubview(button)
//        button.addTarget(self, action: #selector(ViewController.incrementCount), forControlEvents: .TouchUpInside)
//        button.addTarget(self, action: #selector(ViewController.toggleBackgroudColor), forControlEvents: .TouchUpInside)
//        
//        //Button2
//        var button2 = UIButton()
//        button2.frame = CGRectMake(300, 250, 60, 60)
//        button2.setTitle("Click", forState: .Normal)
//        button2.setTitleColor(UIColor.blueColor(), forState: .Normal)
//        
//        self.view.addSubview(button2)
//        button2.addTarget(self, action: #selector(ViewController.decrementCount), forControlEvents: .TouchUpInside)
//        button2.addTarget(self, action: #selector(ViewController.toggleBackgroudColor), forControlEvents: .TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func incrementCount() {
        self.count += 1
        self.label.text = "\(self.count)"
        self.label2.text = "\(self.count)"
    }

    func decrementCount() {
        self.count -= 1
        self.label.text = "\(self.count)"
        self.label2.text = "\(self.count)"
    }
    
    func  toggleBackgroudColor() {
        if backgroundToggled {
            self.view.backgroundColor = UIColor.whiteColor()
        } else {
            self.view.backgroundColor = UIColor.greenColor()
        }
        backgroundToggled = !backgroundToggled
    }

}

