//
//  RootTabView.swift
//  Plantapp.swift
//
//  Created by Giulia Guadagno on 06/11/25.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            PlaceholderView(title: "Schedule")
                .tabItem {
                    Image(systemName: "timer")
                    Text("Schedule")
                }

            PlaceholderView(title: "Diagnose")
                .tabItem {
                    Image(systemName: "stethoscope")
                    Text("Diagnose")
                }

            PlaceholderView(title: "Find Plant")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Find Plant")
                }

            NavigationStack {
                ToolkitView()
            }
            .tabItem {
                Image(systemName: "duffle.bag")       // name of your PNG in Assets.xcassets
                    .renderingMode(.template) // allows tint color (teal)
                Text("Toolkit")
            }


            PlaceholderView(title: "My Plants")
                .tabItem {
                    Image(systemName: "leaf")
                    Text("My Plants")
                }
        }
    }
}

struct PlaceholderView: View {
    let title: String
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            Text(title)
                .font(.title).foregroundStyle(.secondary)
        }
    }
}
