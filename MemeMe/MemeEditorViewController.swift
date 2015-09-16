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
        println("pick up an image from camera")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType  = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func pickupImage(sender: UIBarButtonItem) {
        println("pick up an image from album")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType  = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cancelImagePicker(sender: UIBarButtonItem) {
        println("cancel image picker")
        memeImage.image = nil
        changeStateOfTopToolbar(false)
    }
    
    @IBAction func shareImage(sender: UIBarButtonItem) {
        println("share image")
        let memeImagePicker = UIActivityViewController(activityItems: [memedImage!], applicationActivities: nil)
        self.presentViewController(memeImagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImage.image = image
            originalImage = image
            memedImage = image
            self.dismissViewControllerAnimated(true, completion: nil)
            changeStateOfTopToolbar(true)
            println("picker image")
        }
    }
    
    func changeStateOfTopToolbar(state: Bool) {
        shareButton.enabled = state
        cancelButton.enabled = state
    }
    
    // UITextFieldDelegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // replace to upper letter
        // limit the text's width in the text field size
        if let lowercaseCharRange = string.rangeOfCharacterFromSet(NSCharacterSet.lowercaseLetterCharacterSet()) {
            var newText:NSString = textField.text
            newText = newText.stringByReplacingCharactersInRange(range, withString: string.uppercaseString)
            var textSize:CGSize = newText.sizeWithAttributes([NSFontAttributeName: textField.font])
            if textSize.width >= textField.bounds.size.width {
                return false
            }
            textField.text = newText as String
            return false;
        }
        return true;
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        // just clear text in the first time
        if textField.clearsOnBeginEditing {
            textField.clearsOnBeginEditing = false
            return true
        } else {
            return false
        }
    }
    
}

