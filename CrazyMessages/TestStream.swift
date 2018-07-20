//
//  TestStream.swift
//  CrazyMessages
//
//  Created by Meet Vyas on 20/07/18.
//  Copyright © 2018 Erlang Solutions. All rights reserved.
//
import Foundation
import XMPPFramework

class TestStream: NSObject {
    var username: String = ""
    var password: String = ""
    var hostName: String = ""
    var userJID: XMPPJID!
    //var xmppController: XMPPController!
    var xmppStream: XMPPStream!
    
    init(username: String, password: String, host: String, hostPort: UInt16 = 5222) {
        self.username = username
        self.password = password
        self.hostName = host
        let userJID = XMPPJID(string: username)!
        self.userJID = userJID
        self.xmppStream = XMPPStream()
        self.xmppStream.hostName = host
        self.xmppStream.hostPort = hostPort
        self.xmppStream.startTLSPolicy = XMPPStreamStartTLSPolicy.allowed
        self.xmppStream.myJID = userJID
        super.init()
        let bgQueue = DispatchQueue(label: "com.xmpp.background.queue", qos: .userInitiated, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
        self.xmppStream.addDelegate(self, delegateQueue: bgQueue)
    }
    
    func connect() {
        if !self.xmppStream.isDisconnected {
            return
        }
        do {
            try self.xmppStream.connect(withTimeout: XMPPStreamTimeoutNone)
        } catch {
            print("STREAM CONNECT CATCHED ERROR ===> \(error.localizedDescription)")
        }
    }
}

extension TestStream: XMPPStreamDelegate {
    func xmppStreamDidConnect(_ stream: XMPPStream) {
        print("Stream: Connected")
        // stream.disconnectAfterSending()
        try! stream.authenticate(withPassword: self.password)
    }
    
    func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
        self.xmppStream.send(XMPPPresence())
        print("Stream: Authenticated")
    }
    
    func xmppStream(_ sender: XMPPStream, didNotAuthenticate error: DDXMLElement) {
        print("Stream: Fail to Authenticate")
    }
}
