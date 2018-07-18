//
//  MessagesViewController.swift
//  CrazyMessages
//
//  Created by Meet Vyas on 18/07/18.
//  Copyright © 2018 Erlang Solutions. All rights reserved.
//

import UIKit
import XMPPFramework

class MessagesViewController: UIViewController {
    
    var messages = [String:String]()
    
    var xmppController: XMPPController!

    @IBOutlet weak var messageTxt: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.xmppController.messageDelegate = self
    }
}

extension MessagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageCell") else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
}


extension MessagesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell is selected")
    }
}

extension MessagesViewController : MessageDelegate {
    func messageReceived(message: XMPPMessage) {
        print("XMPP Message Received ===> ",message)
    }
}
