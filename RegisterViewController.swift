//
//  RegisterViewController.swift
//  CryptoApp
//
//  Created by Daniel Bessonov on 6/27/17.
//  Copyright © 2017 Daniel Bessonov. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RegisterViewController : UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // generate random String with length of N
    func generateRandomSalt(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    // hash string with sha256
    func sha256(string: String) -> Data? {
        guard let messageData = string.data(using:String.Encoding.utf8) else { return nil; }
        var digestData = Data(count: Int(CC_SHA256_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_SHA256(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        return digestData
    }
    
    // register user into CoreData model; encrypt password with SHA256 + salt
    @IBAction func register(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // generate salt
        let salt = generateRandomSalt(length: 10)
        // generate UserAccount
        let userAccount = NSEntityDescription.insertNewObject(forEntityName: "UserAccount", into: context) as! UserAccount
        userAccount.salt = salt
        userAccount.username = self.usernameField.text!
        userAccount.password = sha256(string: (self.passwordField.text! + salt))! as NSData
        do {
            try context.save()
        } catch let saveError as NSError {
            print("Save error: \(saveError.localizedDescription)")
        }
        self.navigationController?.popViewController(animated: false)
        self.performSegue(withIdentifier: "goBack", sender: self)
    }
    
    // enabled popup in ViewController (for successful registration)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC : ViewController = segue.destination as! ViewController
        destVC.fromRegister = true
    }

}















