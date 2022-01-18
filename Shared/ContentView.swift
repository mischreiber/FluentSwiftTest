//
//  ContentView.swift
//  Shared
//
//  Created by Michael Schreiber on 1/17/22.
//

import SwiftUI
import FluentUI

struct DemoLookup {
    let name: String
    let view: AnyView
}

struct ContentView: View {
    let demos: [DemoLookup] = [
        DemoLookup(name: "Avatar", view: AnyView(AvatarDemoView()))
    ]
    
    var body: some View {
        NavigationView {
            List(demos, id: \.self.name) { demo in
                NavigationLink(
                    destination: demo.view.navigationTitle(demo.name)) {
                        Text(demo.name)
                }
            }.navigationTitle("FluentUI")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
