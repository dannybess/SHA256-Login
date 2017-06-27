//
//  ViewController.swift
//  CryptoApp
//
//  Created by Daniel Bessonov on 6/27/17.
//  Copyright © 2017 Daniel Bessonov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // check if ViewController is being displayed from RegisterVC
    var fromRegister : Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        if(fromRegister) {
            let alert = UIAlertController(title: "Registration", message: "You are now registered!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

