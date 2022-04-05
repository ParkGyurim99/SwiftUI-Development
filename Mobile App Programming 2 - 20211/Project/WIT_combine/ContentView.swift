import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var session: SessionStore
    
    func listen(){
        session.listen()
    }
    
    var body: some View {
//        Group{
        NavigationView {
            if(session.session != nil){
                Home()
            } else {
                logIn()
            }
//            logIn()
        }.onAppear(perform: listen)
        
    }
}
