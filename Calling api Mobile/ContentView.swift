//
//  ContentView.swift
//  Calling api Mobile
//
//  Created by Samuel Amante on 5/21/25.
//

import SwiftUI

struct ContentView: View {
    @State private var competitions: [Competition] = []
    @State private var showError = false

    var body: some View {
        NavigationView {
            List(competitions) { comp in
                NavigationLink(destination: CompetitionDetailView(competition: comp)) {
                    VStack(alignment: .leading) {
                        Text(comp.name).font(.headline)
                        Text("Region: \(comp.area.name)")
                            .font(.subheadline).foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Competitions")
            .task {
                await fetchCompetitions()
            }
            .alert("Error", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Failed to load competitions.")
            }
        }
    }

    func fetchCompetitions() async {
        guard let url = URL(string: "https://api.football-data.org/v4/competitions") else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(CompetitionsResponse.self, from: data)
            competitions = decoded.competitions
        } catch {
            showError = true
        }
    }
}

#Preview {
    ContentView()
}
