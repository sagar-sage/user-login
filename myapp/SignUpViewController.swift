//
//  SignUpViewController.swift
//  myapp
//
//  Created by Sagar Chhetri on 1/21/16.
//  Copyright © 2016 Sagar Chhetri. All rights reserved.
//

import UIKit
import Parse


class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: Properties
    
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    
    @IBOutlet weak var userEmailAddressTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBOutlet weak var userConformPasswordTextfield: UITextField!
    
    @IBOutlet weak var userFirstnameTextField: UITextField!
    @IBOutlet weak var userLastnameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        self.edgesForExtendedLayout = UIRectEdge()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Action Button
    
    @IBAction func selectProfilePhotoButtonTapped(sender: AnyObject) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(myPickerController, animated: true, completion: nil)
    }
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    // MARK: UiImage delegate functions
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        profilePhotoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //validating sign up form
    @IBAction func signUpButtonTapped(sender: AnyObject) {
        let userName: String? = userEmailAddressTextField.text
        let password: String? = userPasswordTextField.text
        let confirmPasssword: String? = userConformPasswordTextfield.text
        let firstName: String? = userFirstnameTextField.text
        let lastName: String? = userLastnameTextField.text
        
        let user: PFUser = PFUser()
        
        if (userName!.isEmpty || password!.isEmpty || confirmPasssword!.isEmpty || firstName!.isEmpty || lastName!.isEmpty){
            let myAlert = UIAlertController(title: "Alert", message: "All the field should be filled up", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion: nil)
            return
        }
        
        if (password != confirmPasssword ){
            let myAlert = UIAlertController(title: "Alert", message: "Password doesn't match, Please Try Again", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion: nil)
            return
        }
        
        
        user.username = userName!
        user.password = password!
        user.email = userName!
        user.setObject(firstName!, forKey: "first_name")
        user.setObject(lastName!, forKey: "last_name")
    
        let photoImageData = UIImageJPEGRepresentation(profilePhotoImageView.image!, 1)
        if (photoImageData != nil){
            //Create a PFFile object to be sent to parse could serve
            let profileImageFile = PFFile(data: photoImageData!)
            user.setObject(profileImageFile!, forKey: "profile_picture")
        }
        user.signUpInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            var userMessage = "Registration is successful. Thank YOU"
            if (!success){
                userMessage = error!.localizedDescription
            }
            let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){ action in
                if(success){
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
            
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
         
        
        
    }
    
}

/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
}
*/



