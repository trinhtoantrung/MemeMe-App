//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by  Trung Trinh on 9/7/15.
//  Copyright (c) 2015 Trung Trinh. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    var memeData: Meme?
    var originalImage:UIImage?
    var memedImage:UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        originalImage = UIImage()
        memedImage = UIImage()
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!,
            NSStrokeWidthAttributeName : -3.0]
        
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.borderStyle = .None
        topTextField.backgroundColor = UIColor.clearColor()
        topTextField.text = "TOP"
        topTextField.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
        topTextField.textAlignment = NSTextAlignment.Center
        topTextField.clearsOnBeginEditing = true
        topTextField.adjustsFontSizeToFitWidth = false
        topTextField.delegate = self
        
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.borderStyle = .None
        bottomTextField.backgroundColor = UIColor.clearColor()
        bottomTextField.text = "BOTTOM"
        bottomTextField.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
        bottomTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.clearsOnBeginEditing = true
        bottomTextField.adjustsFontSizeToFitWidth = false
        
        bottomTextField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        if memeImage.image == nil {
            changeStateOfTopToolbar(false)
        }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func captureImage(sender: UIBarButtonItem) {
        print("pick up an image from camera")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType  = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func pickupImage(sender: UIBarButtonItem) {
        print("pick up an image from album")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType  = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cancelImagePicker(sender: UIBarButtonItem) {
        print("cancel image picker")
        memeImage.image = nil
        changeStateOfTopToolbar(false)
    }
    
    @IBAction func shareImage(sender: UIBarButtonItem) {
        print("share image")
        let memeImagePicker = UIActivityViewController(activityItems: [memedImage!], applicationActivities: nil)
        self.presentViewController(memeImagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImage.image = image
            originalImage = image
            memedImage = image
            self.dismissViewControllerAnimated(true, completion: nil)
            changeStateOfTopToolbar(true)
            print("picker image")
        }
    }
    
    func changeStateOfTopToolbar(state: Bool) {
        shareButton.enabled = state
        cancelButton.enabled = state
    }
    
    // UITextFieldDelegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // limit the text's width in the text field size
        
        print("textfield should be changed")
        if string != "" {
            let newText:NSString = textField.text!
            let textSize:CGSize = newText.sizeWithAttributes([NSFontAttributeName: textField.font!])
            if textSize.width + 20 >= textField.bounds.size.width {
                print("string is over width's text field")
                return false
            }
        }
        return true;
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // just clear text in the first time
        print("clear in the first time")
        if textField.clearsOnBeginEditing {
            textField.clearsOnBeginEditing = false
        }
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        print("clear")
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("return")
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("return by touch")
        topTextField.resignFirstResponder()
        bottomTextField.resignFirstResponder()
    }
    
}

