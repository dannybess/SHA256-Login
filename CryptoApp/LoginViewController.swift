//
//  LoginViewController.swift
//  CryptoApp
//
//  Created by Daniel Bessonov on 6/27/17.
//  Copyright © 2017 Daniel Bessonov. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class LoginViewController : UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    var userAccounts : [UserAccount] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    // return hash associated with username
    func returnHash(array : [UserAccount], name : String) -> NSData? {
        for account in array {
            if account.username! == name {
                return account.password!
            }
        }
        return nil
    }
    
    // return salt associated with username
    func returnSalt(array : [UserAccount], name : String) -> String? {
        for account in array {
            if account.username! == name {
                return account.salt!
            }
        }
        return nil
    }

    // login user
    @IBAction func login(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<UserAccount>(entityName: "UserAccount")
        self.userAccounts = try! context.fetch(request)
        // retrieve data
        let hash = returnHash(array: self.userAccounts, name: self.usernameField.text!)
        let salt = returnSalt(array: self.userAccounts, name: self.usernameField.text!)
        let reHashedPassword = sha256(string: self.passwordField.text! + salt!)! as NSData
        // compare hashed passwords
        if(hash != nil && salt != nil) {
            if(reHashedPassword.isEqual(to: hash! as Data)) {
                let alert = UIAlertController(title: "Login", message: "You are now logged in!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertController(title: "Login", message: "Wrong password boi!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}







