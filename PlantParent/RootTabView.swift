//
//  RootTabView.swift
//  Plantapp.swift
//
//  Created by Giulia Guadagno on 06/11/25.
//

import SwiftUI

struct TabBarView: View {
    @State private var activeTab: TabKey = .game
    
    var body: some View {
        HStack {
            TabView(selection: $activeTab) {
                Tab("Schedule", systemImage: "gauge.with.needle.fill", value: TabKey.drinks) {
                    //DrinksView()
                }
                Tab("My Plants", systemImage: "leaf", value: TabKey.home) {
                    //ToolkitView()
                }
                Tab("Diagnose", systemImage: "heart.text.clipboard.fill", value: TabKey.plant) {
                    //GameView()
                }
                Tab("Toolkit", systemImage: "bag", value: TabKey.game) {
                    NavigationStack {
                        ToolkitView()
                    }
                }
                Tab(value: TabKey.search, role: .search) {
                    //SearchView()
                }
            }
            .tabBarMinimizeBehavior(.onScrollDown)
        }
    }
}

#Preview {
    TabBarView()
}

private enum TabKey {
    case drinks, home, game, plant, search
}
