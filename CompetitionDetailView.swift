//
//  CompetitionDetailView.swift
//  Calling api Mobile
//
//  Created by Samuel Amante on 5/22/25.
//

import SwiftUI

struct CompetitionDetailView: View {
    let competition: Competition

    var body: some View {
        VStack(spacing: 20) {
            Text(competition.name)
                .font(.largeTitle)
                .bold()

            if let code = competition.code {
                Text("Code: \(code)")
            }

            Text("Type: \(competition.type)")
            
            if let plan = competition.plan {
                Text("Plan: \(plan)")
            }

            if let season = competition.currentSeason {
                VStack {
                    Text("Current Season:")
                        .font(.headline)
                    Text("Start: \(season.startDate)")
                    Text("End: \(season.endDate)")
                    if let matchday = season.currentMatchday {
                        Text("Matchday: \(matchday)")
                    }
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Details")
    }
}

struct CompetitionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCompetition = Competition(
            id: 123,
            name: "Champions League",
            area: Area(name: "Europe", code: "UEFA"),
            code: "UCL",
            type: "CUP",
            plan: "TIER_ONE",
            currentSeason: Season(
                startDate: "2023-09-01",
                endDate: "2024-06-10",
                currentMatchday: 5
            )
        )

        NavigationView {
            CompetitionDetailView(competition: sampleCompetition)
        }
    }
}


#Preview {
    CompetitionDetailView()
}
