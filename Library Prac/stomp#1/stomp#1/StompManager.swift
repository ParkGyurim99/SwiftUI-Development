//
//  StompManager.swift
//  stomp#1
//
//  Created by Park Gyurim on 2021/12/27.
//

import Foundation
import StompClientLib

class StompManager {
    let chatId : Int
    
    // Singleton Pattern
    //static let shared : StompManager = StompManager(40) // TEMP

    //private let url = NSURL(string : "ws://3.36.233.180:8080/stomp/chat/websocket")!
    private let url = URL(string: "ws://3.36.23.26:8080/stomp/chat/websocket")!
    private let accessToken : String
    
    // Publish Payload (Data)
    private var payloadObject = [
        "memberId" : "5",
        "chatId" : "",
        "message" : "null",
        //"image" : "null",
        "accessToken" : "accessToken"  //"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0QGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfQURNSU4iXSwiaWF0IjoxNjQxMzY2NDQwLCJleHAiOjE2NDEzNjgyNDB9.jCKBJNQWFc3yOKwSKrmpc9qEt9ynsZyuiD-3CYZZKn8"
    ]
    
    // Socket instance
    var socketClient = StompClientLib()
    
    init(_ chatRoomNumber : Int, token : String) {
        chatId = chatRoomNumber
        accessToken = token
        registerSockect()
    }
    
    // Socket Connection
    func registerSockect() {
        socketClient.openSocketWithURLRequest(
            request: NSURLRequest(url: url), // as URL),
            delegate: self,
            connectionHeaders: [ "X-AUTH-TOKEN" : accessToken ] // , "heart-beat": "0,10000"
        )
    }
    
    // Subscribe
    //func subscribe(chatId : String) {
    func subscribe() {
        //socketClient.subscribe(destination: "/sub/chat/room/"  + chatId)
        
        let destination : String = "/sub/chat/room/\(chatId)"//  + chatId
        let ack = "ack_\(destination)" // It can be any unique string
        let subsId = "subscription_\(destination)" // It can be any unique string
        let header = ["destination": destination, "ack": ack, "id": subsId]

        socketClient.subscribeWithHeader(destination: destination, withHeader: header)
        print("Subscribe topic - /sub/chat/room/\(chatId)")// + chatId)
        print("-- Subscribe with header : ")
        print(header)
        
        payloadObject["chatId"] = "\(chatId)"
    }
    
    // Send Message - Publish
    func sendMessage(message : String) {
        payloadObject["message"] = message
        //payloadObject["image"] = "null"
        payloadObject["accessToken"] = accessToken
        
        socketClient.sendJSONForDict(dict: payloadObject as AnyObject, toDestination: "/pub/chat/message")
    }
    
    // Unsubscribe
    func disconnect() {
        socketClient.disconnect()
    }
}

// Delegate - CALLBACK Functions
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
    
    // Unsubscribe Topic
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Stomp socket \(chatId) is disconnected")
    }
    
    // Subscribe Topic
    func stompClientDidConnect(client: StompClientLib!) {
        print("Stomp socket \(chatId) is connected")
    
        subscribe()
        // -> register 랑 subscribe 분리
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
