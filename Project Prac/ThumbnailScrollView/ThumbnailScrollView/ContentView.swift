//
//  ContentView.swift
//  ThumbnailScrollView
//
//  Created by Park Gyurim on 2023/02/25.
//

import SwiftUI

struct ContentView: View {
    @State var showConfirmationDialog = false
    
    private var trailingButtons: some View {
        HStack(alignment: .center, spacing: 16) {
            ShareLink(item: URL(string: "naver.com")!) {
                Image(systemName: "square.and.arrow.up")
            }
            Button {
                showConfirmationDialog = true
            } label: {
                Image(systemName: "ellipsis")
            }
        }.confirmationDialog(
            "Confirmation Dialog Title",
            isPresented: $showConfirmationDialog,
            titleVisibility: .visible,
            actions: {
                Button("Action 1", role: .none) { }
                Button("Action 1", role: .none) { }
                Button("Action 3", role: .destructive) { }
                Button("Cancel", role: .cancel) { }
            },
            message: {
                Text("Confirmation Dialog Description")
            }
        )
    }
    
    var body: some View {
        ThumbnailScrollView.WithPreference(contents: .dummy) { trailingButtons }

        // ThumbnailScrollView.WithGeometryReader(contents: .dummy, thumbnailSize: .large)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
