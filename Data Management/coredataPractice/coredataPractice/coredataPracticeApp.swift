//
//  coredataPracticeApp.swift
//  coredataPractice
//
//  Created by 박규림 on 2021/02/03.
//

import SwiftUI

@main
struct coredataPracticeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            //  The “environment” is where system-wide settings are saved, for instance, Calendar, Locale, ColorScheme, and now, also the viewContext contained in the persistenceController’s container property.
        }
    }
}
