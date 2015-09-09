//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by  Trung Trinh on 9/7/15.
//  Copyright (c) 2015 Trung Trinh. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var memeData: Meme?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        if memeImage.image == nil {
            changeStateOfTopToolbar(false)        }
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
        let memeImagePicker = UIActivityViewController()
        self.presentViewController(memeImagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImage.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
            changeStateOfTopToolbar(true)
        }
    }
    
    func changeStateOfTopToolbar(state: Bool) {
        shareButton.enabled = state
        cancelButton.enabled = state
    }
}

