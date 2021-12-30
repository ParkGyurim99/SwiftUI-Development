//
//  StompManager.swift
//  stomp#1
//
//  Created by Park Gyurim on 2021/12/27.
//

import Foundation
import StompClientLib

class StompManager {
    // Singleton Pattern
    static let shared : StompManager = StompManager()
    
    private let url = NSURL(string : "ws://3.36.233.180:8080/stomp/chat/websocket")!
    private let accessToken : String = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0QGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfVVNFUiJdLCJpYXQiOjE2NDA4ODU2NDksImV4cCI6MTY0MDg4NzQ0OX0.u7kzIvolxxnxetkjo-Cypy8OGya8GsBrOYfrrDNiPvE"
    
    // Publish Payload (Data)
    private let payloadObject = [
        "memberId" : "5",
        "chatId" : "43",
        "message" : "STOMP TEST IN iOS",
        //"image" : "",
        "accessToken" :  "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0QGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfVVNFUiJdLCJpYXQiOjE2NDA4ODU2NDksImV4cCI6MTY0MDg4NzQ0OX0.u7kzIvolxxnxetkjo-Cypy8OGya8GsBrOYfrrDNiPvE"
    ]
    
    // Socket instance
    var socketClient = StompClientLib()
    
    // Socket Connection
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
    
    // Send Message - Publish
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

// Delegate - CALLBACK Functions
extension StompManager : StompClientLibDelegate {
    // didReceiveMessageWithJSONBody ( Message Received via STOMP )
    // STOMP 통해서 구독중인 채널에서 메시지가 오면 처리함..
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
    
    // Unsubscribe Topic
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Stomp socket is disconnected")
    }
    
    // Subscribe Topic
    func stompClientDidConnect(client: StompClientLib!) {
        print("Stomp socket is connected")
        subscribe()
    }
    
    // Error - disconnect and reconnect socket
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
