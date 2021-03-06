//
//  LoginViewController.swift
//  CrazyMessages
//
//  Created by Andres on 7/21/16.
//  Copyright © 2016 Andres. All rights reserved.
//

import UIKit
import XMPPFramework
import MBProgressHUD

class LogInViewController: UIViewController {

	@IBOutlet weak var userJIDLabel: UITextField!
	@IBOutlet weak var userPasswordLabel: UITextField!
	@IBOutlet weak var serverLabel: UITextField!
	@IBOutlet weak var errorLabel: UILabel!

	weak var delegate:LogInViewControllerDelegate?
	var hud: MBProgressHUD!
    
    var xmppController: XMPPController!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        self.userJIDLabel.text = "user1@localhost"
        self.userPasswordLabel.text = "root123"
        self.serverLabel.text = "ec2-52-53-215-232.us-west-1.compute.amazonaws.com"
        */
        self.userJIDLabel.text = "meet.vyas@localhost"
        self.userPasswordLabel.text = "12345"
        self.serverLabel.text = "sandbox.aavgo.com"
	}

	@IBAction func logInAction(sender: AnyObject) {
		if self.userJIDLabel.text?.count == 0
		  || self.userPasswordLabel.text?.count == 0
		  || self.serverLabel.text?.count == 0 {
				
			self.errorLabel.text = "Something is missing or wrong!"
			return
		}

        guard let _ = XMPPJID(string: self.userJIDLabel.text!) else {
			self.errorLabel.text = "Username is not a jid!"
			return
		}

        self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
		self.hud.label.text = "Signing in..."
		
        self.delegate?.didTouchLogIn(sender: self, userJID: self.userJIDLabel.text!, userPassword: self.userPasswordLabel.text!, server: self.serverLabel.text!)
	}
    
    @IBAction func multipleConnections(_ sender: UIButton) {
        
        /*
        for i in 10...110 {
            sleep(1)
            DispatchQueue.global(qos: .userInitiated).async {
                print("===> CONNECTING USER \(i) <===")
                let userJID = "user\(i)@localhost"
                let password = "root123"
                let host = "ec2-52-53-215-232.us-west-1.compute.amazonaws.com"
                // let dispatchQueue = DispatchQueue(label: "com.backgroundQueue1.stream.test", qos: .userInitiated, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
                do {
                    try self.xmppController = XMPPController(hostName: host, userJIDString: userJID, password: password)
                    self.xmppController.connect()
                } catch {
                    print("Something went wrong")
                }
            }
        }
        */
        
        /*
        let userJID = "user1@localhost"
        let password = "root123"
        let host = "ec2-52-53-215-232.us-west-1.compute.amazonaws.com"
        
//        let testObject = TestStream(username: userJID, password: password, host: host)
//        testObject.connect()
        do {
            try self.testXMPPController =  TestXMPPController(hostName: host,
                                                    userJIDString: userJID,
                                                    password: password)
            // self.xmppController.xmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
            self.testXMPPController.connect()
        } catch {
            // sender.showErrorMessage(message: "Something went wrong")
            print("Something went wrong")
        }
 
        */
    
        /*
        DispatchQueue.global(qos: .userInitiated).async {
            for i in 10...100 {
                sleep(3)
                print("===> CONNECTING USER \(i) <===")
                let userJID = "user\(i)@localhost"
                let password = "root123"
                let host = "ec2-52-53-215-232.us-west-1.compute.amazonaws.com"
                do {
                    try self.xmppController = XMPPController(hostName: host,
                                                             userJIDString: userJID,
                                                             password: password)
                    // self.xmppController.xmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
                    self.xmppController.connect()
                } catch {
                    // sender.showErrorMessage(message: "Something went wrong")
                    print("Something went wrong")
                }
            }
        }
        */
        
        for i in 10...2000 {
            print("===> CONNECTING USER \(i) <===")
            // usleep(500)
            // Thread.sleep(forTimeInterval: 1)
            sleep(3)
            let userJID = "user\(i)@localhost"
            let password = "root123"
            let host = "ec2-52-53-215-232.us-west-1.compute.amazonaws.com"
            do {
                try self.xmppController = XMPPController(hostName: host,
                                                        userJIDString: userJID,
                                                        password: password)
                // self.xmppController.xmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
                self.xmppController.connect()
            } catch {
                // sender.showErrorMessage(message: "Something went wrong")
                print("Something went wrong")
            }
        }
    }
    
	func showErrorMessage(message: String) {
		hud.mode = .text
		hud.label.text = message
		hud.hide(animated: true, afterDelay: 1.5)
	}

}

protocol LogInViewControllerDelegate: class {
	func didTouchLogIn(sender: LogInViewController, userJID: String, userPassword: String, server: String)
}
