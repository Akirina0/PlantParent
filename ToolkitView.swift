//
//  ToolkitView.swift
//  Plantapp.swift
//
//  Created by Giulia Guadagno on 06/11/25.
//

import SwiftUI

struct ToolkitView: View {
    var body: some View {
        ZStack(alignment: .top) {
            // Header gradient background
            Color(.systemGroupedBackground).ignoresSafeArea()
            LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color.mint.opacity(0.45), location: 0.0),
                        .init(color: Color.mint.opacity(0.18), location: 0.65),
                        .init(color: .clear,                    location: 1.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 220)
                .ignoresSafeArea(edges: .top)
                .compositingGroup()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {

                    // Top bar
                    HStack {
                        Text("Toolkit")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                        Button { /* settings action */ } label: {
                            Image(systemName: "gearshape.fill")
                                .font(.title3)
                                .foregroundStyle(.primary)
                                .padding(18)
                                .background(.ultraThinMaterial, in: Circle())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)

                    // Gardening Tools
                    SectionHeader(title: "Gardening Tools")
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ToolCard(icon: "drop.fill", title: "Water Calculator")
                            ToolCard(icon: "sun.max.fill", title: "Light Meter")
                            ToolCard(icon: "leaf", title: "Repotting Check")
                        }
                        .padding(.horizontal)
                    }

                    // Care Courses
                    SectionHeader(title: "Care Courses") {
                        Button("View all >") { }
                            .font(.callout)
                            .foregroundStyle(.teal)
                    }
                    .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {

                            CourseCard(imageName: "Pothos golden", title: "Golden pothos")
                            CourseCard(imageName: "Peace lily", title: "Peace lily")
                            CourseCard(imageName: "Corn plant", title: "Corn plant")
                        }
                        .padding(.horizontal)
                    }

                    // Home Remedies
                    SectionHeader(title: "Home Remedies")
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            // IMPORTANTE: Assicurati di avere immagini con questi nomi nel tuo Assets.xcassets
                            RemedyCard(imageName: "First_homemade", badge: "Fungicide")
                            RemedyCard(imageName: "Second_homemade", badge: "Pesticide")
                            RemedyCard(imageName: "cami_tre", badge: "Fertilizer")
                        }
                        .padding(.horizontal)
                    }

                    Spacer(minLength: 24)
                }
                .padding(.top, 12)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Components

/// Section header with optional trailing content (e.g., "View all >")
struct SectionHeader<Content: View>: View {
    let title: String
    @ViewBuilder var trailing: Content

    init(title: String, @ViewBuilder trailing: () -> Content = { EmptyView() }) {
        self.title = title
        self.trailing = trailing()
    }

    var body: some View {
        HStack {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
            Spacer()
            trailing
        }
    }
}

/// Small tool card (icon + two-line title)
struct ToolCard: View {
    var icon: String
    var title: String

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.background)
                .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 3)
            
            VStack(alignment: .leading, spacing: 45) {
                Image(systemName: icon)
                    .font(.title2)
                    .frame(width: 36, height: 36)
                    .foregroundStyle(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.teal)
                    )

                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                    .lineLimit(2)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: 150, height: 130)
   }
}
      
/// Horizontal course card (IMMAGINE + title)
struct CourseCard: View {
    var imageName: String
    var title: String

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 170, height: 150)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

            // Gradiente scuro opzionale per rendere leggibile il testo su foto chiare
            LinearGradient(colors: [.clear, .black.opacity(0.6)], startPoint: .center, endPoint: .bottom)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .frame(width: 170, height: 150)

            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .padding(10)
        }
        .frame(width: 170, height: 150)
    }
}

/// Large remedy card with badge (IMMAGINE + badge)
struct RemedyCard: View {
    var imageName: String
    var badge: String

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 220, height: 140)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

            Text(badge)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(.black.opacity(0.35), in: Capsule())
                .padding(10)
        }
        .frame(width: 220, height: 140)
    }
}
