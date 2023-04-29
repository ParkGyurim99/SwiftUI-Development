import SwiftUI
import TuistPracUI
import MyModule

@main
struct TuistPracApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                VStack {
                    ContentView()
                    MyView()
                }
            }
        }
    }
}
