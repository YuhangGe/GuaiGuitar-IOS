//
//  ViewController.swift
//  GuaiGuitar
//
//  Created by 葛羽航 on 14/11/13.
//  Copyright (c) 2014年 xiaoge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var jsView: JSCanvasView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dealTest(sender: AnyObject) {
        
        jsView.background = "blue"
        jsView.fontSize = 25
        jsView.text = "xiaoguai"
        
        jsView.paint()
        
    }

}

