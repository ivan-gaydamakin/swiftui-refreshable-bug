//
//  ContentView.swift
//  SwiftUIRefreshableBug
//
//  Created by Ivan Gaydamakin on 23.09.2021.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            List {
                VStack {
                    Color.yellow.frame(width: 100, height: 200)
                }
            }.refreshable {
                await raiseHand()
            }
            .navigationTitle("Navigation")
            .navigationBarTitleDisplayMode(.inline) // if comment, no bugs
            .toolbar(content: {
                NavigationLink(destination: SecondView()) {
                    Text("Show Detail View")
                }
            })
        }
    }
    
    private func raiseHand() async {
        await withCheckedContinuation { continuation in
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(11)) {
                continuation.resume()
            }
        }
    }
}

struct SecondView: View {
    var body: some View {
        VStack {
            Text("This is the detail view")
            Spacer()
            Text("Some text")
        }
        .navigationTitle("Second")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
