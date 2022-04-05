import SwiftUI
import Firebase
@main
struct WITApp: App {
    
    //for firebasce connection
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(SessionStore()) //필수이다.
        }
    }
}

//firebase connection
class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print("Firevase is connected")
        FirebaseApp.configure()
        return true
    }
}
