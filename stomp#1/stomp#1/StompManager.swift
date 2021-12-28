//
//  StompManager.swift
//  stomp#1
//
//  Created by Park Gyurim on 2021/12/27.
//

import Foundation
import StompClientLib

class StompManager {
    static let shared : StompManager = StompManager()
    private let url = NSURL(string : "ws://3.36.233.180:8080/stomp/chat/websocket")!
    private let accessToken : String = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0QGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfVVNFUiJdLCJpYXQiOjE2NDA3MTQ2NzUsImV4cCI6MTY0MDcxNjQ3NX0.u3fZka_nN4V-6KLLYCG93rEXiVu61qEzI5GGmtHzGNM"
    
    private let payloadObject = [
        "memberId" : "5",
        "chatId" : "71",
        "message" : "STOMP TEST IN iOS",
        //"image" : "",
        "accessToken" :  "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0QGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfVVNFUiJdLCJpYXQiOjE2NDA3MTQ2NzUsImV4cCI6MTY0MDcxNjQ3NX0.u3fZka_nN4V-6KLLYCG93rEXiVu61qEzI5GGmtHzGNM"
    ]
    
    //var socketClient : StompClientLib? = nil
    var socketClient = StompClientLib()
    
    func registerSockect() {
        socketClient.openSocketWithURLRequest(
            request: NSURLRequest(url: url as URL),
            delegate: self,
            connectionHeaders: [ "X-AUTH-TOKEN" : accessToken ]
        )
    }
    
    // Subscribe
    func subscribe() {
        socketClient.subscribe(destination: "/sub/chat/room/43")
        print("Subscribe topic - /sub/chat/room/43")
    }
    
    // Send Message
    func sendMessage() {
        socketClient.sendJSONForDict(dict: payloadObject as AnyObject, toDestination: "/pub/chat/message")
        
        //socketClient.sendMessage(
        //    message : payload,
        //    toDestination: "/sub/chat/room/43",
        //    withHeaders: [ "X-AUTH-TOKEN" : accessToken ],
        //    withReceipt: nil
        //)
    }
    
    // Unsubscribe
    func disconnect() {
        socketClient.disconnect()
    }
}

// Delegate
extension StompManager : StompClientLibDelegate {
    // didReceiveMessageWithJSONBody ( Message Received via STOMP )
    func stompClient(
            client: StompClientLib!,
            didReceiveMessageWithJSONBody jsonBody: AnyObject?,
            akaStringBody stringBody: String?,
            withHeader header: [String : String]?,
            withDestination destination: String
        ) {
            print("DESTINATION : \(destination)")
            print("HEADER : \(header ?? ["nil":"nil"])")
            print("JSON BODY : \(String(describing: jsonBody))")
            //print("String Body : \(stringBody ?? "nil")")
    }
    
    // didReceiveMessageWithJSONBody ( Message Received via STOMP as String )
    func stompClientJSONBody(
            client: StompClientLib!,
            didReceiveMessageWithJSONBody jsonBody: String?,
            withHeader header: [String : String]?,
            withDestination destination: String
        ) {
          print("DESTINATION : \(destination)")
          print("String JSON BODY : \(String(describing: jsonBody))")
    }
    
    // Callback : Unsubscribe Topic
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Stomp socket is disconnected")
    }
    
    // Callback : Subscribe Topic
    func stompClientDidConnect(client: StompClientLib!) {
        print("Stomp socket is connected")
        subscribe()
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print("Error send : " + description)
        
        socketClient.disconnect()
        registerSockect()
    }
    
    func serverDidSendPing() {
        print("Server ping")
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print("Receipt : \(receiptId)")
    }
}
