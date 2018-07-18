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
    
    var messages = [[String:String]]()
    
    var xmppController: XMPPController!

    @IBOutlet weak var messageTxt: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.xmppController.joinOrCreateRoom()
        self.messageTxt.becomeFirstResponder()
        self.navigationItem.hidesBackButton = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.xmppController.messageDelegate = self
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        // self.sendMessage(to: "dhaval@localhost")
        self.sendMessageToGroup()
    }
    
    func sendMessage(to user:String) {
        if self.messageTxt.text?.trimmingCharacters(in: .whitespaces) != "" {
            let message = self.messageTxt.text!
            let senderJID = XMPPJID(string: user)!
            let msg = XMPPMessage(type: "chat", to: senderJID)
            msg.addBody(message)
            self.xmppController.xmppStream.send(msg)
        }
        self.messageTxt.text = ""
    }
    
    func sendMessageToGroup() {
        if self.messageTxt.text?.trimmingCharacters(in: .whitespaces) != "" {
            self.xmppController.xmppRoom.sendMessage(withBody: self.messageTxt.text!)
        }
        self.messageTxt.text = ""
    }
}

extension MessagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageCell") else {
            return UITableViewCell()
        }
        if let message = self.messages[indexPath.row]["message"] {
            cell.textLabel?.text = message
        }
        if let fromText = self.messages[indexPath.row]["from"] {
            cell.detailTextLabel?.text = fromText
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
        // print("FROM ==> ",message.attribute(forName: "from")?.stringValue)
        if let bodyElement = message.forName("body"), let messageTxt = bodyElement.stringValue {
            // if !self.messages.isEmpty { self.messages.removeAll() }
            var messageDict = ["message":messageTxt]
            if let attribute = message.attribute(forName: "from"), let fromValue = attribute.stringValue {
                messageDict["from"] = fromValue
            }
            self.messages.append(messageDict)
            self.tableView.reloadData()
        }
    }
}
