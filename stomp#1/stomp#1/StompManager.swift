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
    //var socketClient : StompClientLib? = nil
    var socketClient = StompClientLib()
    
    func registerSockect() {
        socketClient.openSocketWithURLRequest(
            request: NSURLRequest(url: url as URL),
            delegate: self,
            connectionHeaders: [
                "X-AUTH-TOKEN" : "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0QGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfVVNFUiJdLCJpYXQiOjE2NDA2NjMzOTEsImV4cCI6MTY0MDY2NTE5MX0.40vVvbz95WgznUQ-CCRbuutNCA-uAsyJIGGacP8uxWY"]
        )
    }
    
    func subscribe() {
        print("Subscribe Topic")
        socketClient.subscribe(destination: "/sub/chat/room/71")
    }
    
    func disconnect() {
        socketClient.disconnect()
    }
}

extension StompManager : StompClientLibDelegate {
//    func stompClient(
//            client: StompClientLib!,
//            didReceiveMessageWithJSONBody jsonBody: AnyObject?,
//            akaStringBody stringBody: String?,
//            withHeader header: [String : String]?,
//            withDestination destination: String
//    ) {
//        print("Destination : " + destination)
//        print(jsonBody as Any)
//
//        if stringBody == nil {
//            return
//        }
//
//        guard let data = stringBody!.data(using: .utf8) else {
//            return
//        }
//        print(data)
//    }
    
    // didReceiveMessageWithJSONBody ( Message Received via STOMP )
    func stompClient(
            client: StompClientLib!,
            didReceiveMessageWithJSONBody jsonBody: AnyObject?,
            akaStringBody stringBody: String?,
            withHeader header: [String : String]?,
            withDestination destination: String
        ) {
        print("Destination : \(destination)")
        print("JSON Body : \(String(describing: jsonBody))")
        print("String Body : \(stringBody ?? "nil")")
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
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Stomp socket is disconnected")
    }
    
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
