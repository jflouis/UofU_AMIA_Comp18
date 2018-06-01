//
//  RootViewController.swift
//  LBHI
//
//  Created by Jean Fredo Louis on 5/31/18.
//  Copyright © 2018 com.example. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UIPageViewControllerDelegate {

    var pageViewController: UIPageViewController?

    @IBOutlet weak var txtFname: UITextField!
    @IBOutlet weak var txtPwd: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtACode: UITextField!
    @IBOutlet weak var txtDoB: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Configure the page view controller and add it as a child view controller.
        self.pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        self.pageViewController!.delegate = self

        let startingViewController: DataViewController = self.modelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
        let viewControllers = [startingViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: false, completion: {done in })

        self.pageViewController!.dataSource = self.modelController

        self.addChildViewController(self.pageViewController!)
        self.view.addSubview(self.pageViewController!.view)

        // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
        var pageViewRect = self.view.bounds
        if UIDevice.current.userInterfaceIdiom == .pad {
            pageViewRect = pageViewRect.insetBy(dx: 40.0, dy: 40.0)
        }
        self.pageViewController!.view.frame = pageViewRect

        self.pageViewController!.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var modelController: ModelController {
        // Return the model controller object, creating it if necessary.
        // In more complex implementations, the model controller may be passed to the view controller.
        if _modelController == nil {
            _modelController = ModelController()
        }
        return _modelController!
    }

    var _modelController: ModelController? = nil

    // MARK: - UIPageViewController delegate methods

    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        if (orientation == .portrait) || (orientation == .portraitUpsideDown) || (UIDevice.current.userInterfaceIdiom == .phone) {
            // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to true, so set it to false here.
            let currentViewController = self.pageViewController!.viewControllers![0]
            let viewControllers = [currentViewController]
            self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })

            self.pageViewController!.isDoubleSided = false
            return .min
        }

        // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
        let currentViewController = self.pageViewController!.viewControllers![0] as! DataViewController
        var viewControllers: [UIViewController]

        let indexOfCurrentViewController = self.modelController.indexOfViewController(currentViewController)
        if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
            let nextViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerAfter: currentViewController)
            viewControllers = [currentViewController, nextViewController!]
        } else {
            let previousViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerBefore: currentViewController)
            viewControllers = [previousViewController!, currentViewController]
        }
        self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })

        return .mid
    }

    
    
    //stsart coding for registration
    @IBAction func btnRegistration(sender:AnyObject)
    {
        if(countElements(txtFname.text) == 0){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your first name.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        else if(countElements(txtLname.text) == 0){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your last name.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        else if(countElements(txtDoB.text) == 0){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your Date of Birth.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        else if(countElements(txtEmail.text) == 0){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your first name.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        else if !isValidEmail(txtEmailID.txt){
            var alert: UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your email ID", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
        }
        else if(countElements(txtACode.text) == 0){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your access code.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        else if(countElements(txtpwd.text) == 0){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter a password", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        else{
            var alert : UIAlertView = UIAlertView(title: "User REgistration!", message: "Your Registration is successful.", delegate: nil, cancelButtonTitle: "OK" )
            alert.show()
        }
        
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

