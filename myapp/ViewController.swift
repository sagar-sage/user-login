//
//  ViewController.swift
//  myapp
//
//  Created by Sagar Chhetri on 1/18/16.
//  Copyright © 2016 Sagar Chhetri. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Button Action
    
    @IBAction func signInButton(sender: AnyObject) {
    let userEmail = emailAddressTextField.text
    let userPassword = passwordTextField.text
    
        if (userEmail!.isEmpty || userPassword!.isEmpty){
         return
        }
        PFUser.logInWithUsernameInBackground(userEmail!, password:userPassword!) { (user:PFUser?, error:NSError?) -> Void in
            var  userMessage = "Welcome"
            if (user != nil){
             // Remember the sign in State
                let userName:String? = user?.username
                NSUserDefaults.standardUserDefaults().setObject(
                    userName, forKey: "user_name")
                NSUserDefaults.standardUserDefaults().synchronize()
                //Navigate to Protected Page
                
                let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let mainPage  : MainPageViewController = mainStoryBoard.instantiateViewControllerWithIdentifier(
                "MainPageViewController") as! MainPageViewController
                let mainPageNav = UINavigationController(rootViewController: mainPage)
                let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.window?.rootViewController = mainPageNav
                
                
            }else{
                userMessage = error!.localizedDescription
                let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                myAlert.addAction(okAction)
                self.presentViewController(myAlert, animated: true, completion: nil)
            }
           
        }
    }

}

