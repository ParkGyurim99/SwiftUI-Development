//
//  ContentView.swift
//  PinchToZoomPrac
//
//  Created by Park Gyurim on 2022/04/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("TestImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width : UIScreen.main.bounds.width * 0.95, height : UIScreen.main.bounds.width * 0.5)
                .addPinchZoom()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Add Pinch to Zoom Custom Modifier
extension View {
    func addPinchZoom() -> some View {
        return PinchZoomContext { self }
    }
}

// Helper Struct
struct PinchZoomContext<Content : View> : View {
    var content : Content
    
    init(@ViewBuilder content : @escaping () -> Content) { self.content = content() }
    
    // Offset and Scale Data
    @State var offset : CGPoint = .zero
    @State var scale : CGFloat = 0
    
    @State var scalePosition : CGPoint = .zero
    
    var body: some View {
        content
            // applying offset before scaling
            .offset(x: offset.x, y: offset.y)
            // Using UIKit Gesture for simultaneously recognize Pinch and Pan Gesture
            .overlay(
                ZoomGesture(scale : $scale, offset: $offset, scalePosition: $scalePosition)
            )
            // Scaling Content
            .scaleEffect(1 + scale, anchor: .init(x: scalePosition.x, y: scalePosition.y))
    }
}

struct ZoomGesture : UIViewRepresentable {
    //var size : CGSize
    
    // getting Size for Calculating scale
    @Binding var scale : CGFloat
    @Binding var offset : CGPoint

    @Binding var scalePosition : CGPoint

    // Connecting Coordinator
    func makeCoordinator() -> Coordinator { return Coordinator(parent : self) }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        // adding Gesture
        let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator,
                                                    action: #selector(context.coordinator.handlePinch(sender:)))
        // adding pan Gesture
        let panGesture = UIPanGestureRecognizer(target: context.coordinator,
                                                action: #selector(context.coordinator.handlePan(sender:)))

        panGesture.delegate = context.coordinator
        
        view.addGestureRecognizer(pinchGesture)
        view.addGestureRecognizer(panGesture)
        
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) { }
    
    // Creating Handlers for gesture
    class Coordinator : NSObject, UIGestureRecognizerDelegate {
        var parent : ZoomGesture
        
        init(parent : ZoomGesture) { self.parent = parent }
        
        // making pan to recognize simultaneously
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                               shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
        
        @objc
        func handlePan(sender : UIPanGestureRecognizer) {

            //setting maxTouches
            sender.maximumNumberOfTouches = 2

            // min scale is 1
            if sender.state == .began || sender.state == .changed && parent.scale > 0 {
                if let view = sender.view {
                    // getting translation
                    let translation = sender.translation(in: view)
                    withAnimation { parent.offset = translation }
                }
            } else {
                // setting State to back to normal
                withAnimation {
                    parent.offset = .zero
                    DispatchQueue.main.asyncAfter(
                        deadline: .now() + DispatchTimeInterval.milliseconds(350)
                    ) { self.parent.scalePosition = .zero }
                }
            }
        }
        
        @objc
        func handlePinch(sender : UIPinchGestureRecognizer) {
            // Calculate Scale
            if sender.state == .began || sender.state == .changed {
                // getting the position where the user pinched and apply scale at that position
                let scalePoint = CGPoint(
                    x : sender.location(in: sender.view).x / sender.view!.frame.size.width,
                    y : sender.location(in: sender.view).y / sender.view!.frame.size.height)

                withAnimation {
                    // setting scale // removing added 1
                    parent.scale = sender.scale - 1
                    // so the result will be ((0...1), (0...1))
                    parent.scalePosition = (parent.scalePosition == .zero ? scalePoint : parent.scalePosition)
                }
            } else {
                // Setting scale to 0
                withAnimation(.easeInOut(duration: 0.35)) {
                    parent.scale = 0
                    DispatchQueue.main.asyncAfter(
                        deadline: .now() + DispatchTimeInterval.milliseconds(350)
                    ) { self.parent.scalePosition = .zero }
                }
            }
        }
    }
}
