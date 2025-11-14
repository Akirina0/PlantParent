//
//  ToolkitView.swift
//  Plantapp.swift
//
//  Created by Giulia Guadagno on 06/11/25.
//

import SwiftUI

struct ToolkitView: View {
    @State private var showingSettings = false

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
            .frame(height: 180)
            .ignoresSafeArea(edges: .top)
            .compositingGroup()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {

                    HStack {
                        Text("Toolkit")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                        Button {
                            showingSettings = true
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .font(.title3)
                                .foregroundStyle(.primary)
                                .padding(18)
                                .background(.ultraThinMaterial, in: Circle())
                        }
                        .accessibilityLabel("Settings")
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)

                    // Gardening Tools
                    SectionHeader(title: "Gardening Tools")
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ToolCard(icon: "drop", title: "Water Calculator")
                            ToolCard(icon: "sun.max", title: "Light Meter")
                            ToolCard(icon: "leaf", title: "Repotting Check")
                            ToolCard(icon: "message", title: "AI Botanist")
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, -3)

                    // Care Courses (title is now the navigation link with a chevron)
                    HStack(spacing: 4) {
                        NavigationLink {
                            CareCoursesView()
                        } label: {
                            HStack(spacing: 4) {
                                Text("Care Courses")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundStyle(.black)
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            CourseCard(imageName: "Pothos golden", title: "Golden pothos")
                            // Removed NavigationLink to PeaceLilyDetailView; show as a plain card
                            CourseCard(imageName: "Peace lily", title: "Peace lily")
                            CourseCard(imageName: "Corn plant", title: "Corn plant")
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, -3)

                    // Home Remedies (title is now a navigation link with a chevron)
                    HStack(spacing: 4) {
                        NavigationLink {
                            VStack {
                                Text("Home Remedies")
                                    .font(.title2)
                                    .padding(.top, 24)
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(.systemGroupedBackground).ignoresSafeArea())
                            .navigationTitle("Home Remedies")
                        } label: {
                            HStack(spacing: 4) {
                                Text("Home Remedies")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundStyle(.black)
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            NavigationLink {
                                BakingSodaSprayView()
                            } label: {
                                RemedyCard(imageName: "First_homemade", badge: "Fungicide")
                            }
                            RemedyCard(imageName: "Second_homemade", badge: "Pesticide")
                            RemedyCard(imageName: "Third_homemade", badge: "Fertilizer")
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, -3)

                    Spacer(minLength: 24)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        // Removed .navigationBarTitleDisplayMode and toolbar gear to rely on inline header
        .sheet(isPresented: $showingSettings) {
            SettingsSheet(showing: $showingSettings)
                .presentationDetents([.large]) // Always open fully
                .presentationDragIndicator(.visible)
        }
    }
}

// MARK: - Components

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

struct ToolCard: View {
    var icon: String
    var title: String

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.background)
                // Smaller, subtler shadow
                .shadow(color: .black.opacity(0.10), radius: 4, x: 2, y: 2)

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

struct CourseCard: View {
    var imageName: String
    var title: String

    // Proportional sizing (original: width 170, height 150, corner 16)
    private let targetHeight: CGFloat = 190
    private var scale: CGFloat { targetHeight / 150 }
    private let widthScale: CGFloat = 0.9 // reduce width relative to height scaling
    private var baseScaledWidth: CGFloat { 170 * scale * widthScale }
    private var targetWidth: CGFloat { baseScaledWidth - 15 } // additional -15pt width reduction
    private var cornerRadius: CGFloat { 16 * scale }       // keep curvature proportional to height
    private var textFont: Font { .callout.weight(.semibold) } // slightly larger than subheadline

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: targetWidth, height: targetHeight)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))

            LinearGradient(colors: [.clear, .black.opacity(0.6)], startPoint: .center, endPoint: .bottom)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                .frame(width: targetWidth, height: targetHeight)

            Text(title)
                .font(textFont)
                .foregroundStyle(.white)
                .padding(10 * scale) // scale padding too
        }
        .frame(width: targetWidth, height: targetHeight)
    }
}

struct RemedyCard: View {
    var imageName: String
    var badge: String

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 220, height: 150)
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
        .frame(width: 220, height: 150)
    }
}

// MARK: - Care Courses Destination

struct CareCoursesView: View {
    // Sample data; replace with your real data source as needed
    private let courses: [(image: String, title: String)] = [
        ("Pothos golden", "Golden pothos"),
        ("Peace lily", "Peace lily"),
        ("Corn plant", "Corn plant"),
        ("Croton", "Croton"),
        ("kalanchoe", "Florist Kalanchoe"),
        ("aloe vera", "Aloe Vera"),
        ("chicas", "Chicas"),
        ("swiss cheese", "Swiss Cheese"),
        ("dwarf umbrella", "Dwarf umbrella tree")
    ]

    // Two flexible columns
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(Array(courses.enumerated()), id: \.offset) { _, item in
                    CourseCard(imageName: item.image, title: item.title)
                    // Uses internal 190 height and reduced width
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 24)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle("Care Courses")
    }
}

// MARK: - Settings Sheet UI

struct SettingsSheet: View {
    @Binding var showing: Bool

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("General")) {
                    SettingsRow(title: "Set language")
                    SettingsRow(title: "Notifications")
                    SettingsRow(title: "Clear Cache")
                }

                Section(header: Text("Support")) {
                    SettingsRow(title: "Help")
                    SettingsRow(title: "Contact Us")
                }

                Section(header: Text("Legal")) {
                    SettingsRow(title: "Privacy Policy")
                    SettingsRow(title: "Terms of Use")
                }

                Section(header: Text("About")) {
                    SettingsRow(title: "Encourage Us")
                    SettingsRow(title: "Tell Friends")
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Settings")
                        .font(.headline)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showing = false
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .symbolRenderingMode(.hierarchical)
                    }
                    .accessibilityLabel("Close Settings")
                }
            }
        }
    }
}

struct SettingsRow: View {
    let title: String

    var body: some View {
        NavigationLink {
            VStack {
                Text(title)
                    .font(.title2)
                    .padding(.top, 24)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .navigationTitle(title)
        } label: {
            HStack {
                Text(title)
                    .foregroundStyle(.primary)
                Spacer()
                Text("Detail")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

// MARK: - Remedy Destination

struct BakingSodaSprayView: View {
    var body: some View {
        ScrollView {
            // Increase spacing between section blocks
            VStack(alignment: .leading, spacing: 16) {
                Text("Instructions")
                    .font(.title2)
                    .fontWeight(.bold)

                // Turned into a real list of steps
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .top, spacing: 8) {
                        Text("•")
                        Text("Prepare the solution: Measure 1 tablespoon of baking soda. Pour 1 quart (1 liter) of water into a spray bottle. Add the baking soda to the water.")
                    }
                    HStack(alignment: .top, spacing: 8) {
                        Text("•")
                        Text("Mix well: Secure the lid on the spray bottle and shake thoroughly to ensure the baking soda is fully dissolved.")
                    }
                    HStack(alignment: .top, spacing: 8) {
                        Text("•")
                        Text("Application: Spray the solution onto all parts of the plant, making sure to cover all surfaces thoroughly. Continue spraying until the solution starts to drip off the plant, indicating good coverage.")
                    }
                    HStack(alignment: .top, spacing: 8) {
                        Text("•")
                        Text("Repeat: Apply this spray once every 7 days. Continue this routine for a month (approximately 4 applications).")
                    }
                    // Extra space before Benefits section
                    .padding(.bottom, 16)
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("Benefits")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("This solution is often used as a natural remedy to help control fungal diseases like powdery mildew. Baking soda can alter the pH on the surface of the leaves, creating an environment less favorable for fungal growth.")
                        .padding(.bottom, 16) // add extra space before "Additional Tips"
                }
                VStack(alignment: .leading, spacing: 16) {
                    Text("Additional Tips")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Timing: Spray in the early morning or late evening to avoid the hottest part of the day, which can help prevent leaf burn. Coverage: Ensure you cover both the tops and undersides of the leaves, as well as the stems. Testing: If you are trying this for the first time, test the spray on a small part of the plant first to ensure it doesn't cause any adverse reactions. Storage: Store the spray bottle in a cool, dark place between uses. Shake well before each application.")
                        .padding(.bottom, 16) // add extra space before "Safety"
                }
                VStack(alignment: .leading, spacing: 16) {
                    Text("Safety")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Avoid Overuse: Using this solution too frequently or in too high a concentration can potentially harm your plants by affecting the pH balance of the soil and the leaves. Protective Gear: Consider wearing gloves when mixing and applying the solution to avoid")
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle("Baking Soda Spray")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
}
