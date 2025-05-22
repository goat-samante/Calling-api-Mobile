//
//  ContentView.swift
//  Calling api Mobile
//
//  Created by Samuel Amante on 5/21/25.
//

import SwiftUI

struct ContentView: View {
    @State private var memes = [Meme]()
    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            List(memes) { meme in
                NavigationLink(destination: MemeDetailView(meme: meme)) {
                    Text(meme.name)
                }
            }
            .navigationTitle("Top Memes")
        }
        .task {
            await loadMemes()
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Loading Error"),
                message: Text("There was an error loading memes. Please try again later.")
            )
        }
    }

    func loadMemes() async {
        let urlString = "https://api.imgflip.com/get_memes"
        guard let url = URL(string: urlString) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(MemeResponse.self, from: data)
            DispatchQueue.main.async {
                memes = decoded.data.memes
            }
        } catch {
            DispatchQueue.main.async {
                showingAlert = true
            }
        }
    }
}

struct MemeDetailView: View {
    let meme: Meme

    var body: some View {
        VStack(spacing: 16) {
            Text(meme.name)
                .font(.title)
                .padding(.top)

            if let url = URL(string: meme.url) {
                AsyncImage(url: url) { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(maxHeight: 300)
                } placeholder: {
                    ProgressView()
                }
                .padding()
            }

            Text("Captions: \(meme.captions)")
            Text("Boxes: \(meme.box_count)")

            Spacer()
        }
        .padding()
        .navigationTitle(meme.name)
    }
}

#Preview {
    ContentView()
}

struct MemeResponse: Codable {
    let success: Bool
    let data: MemeData
}

struct MemeData: Codable {
    let memes: [Meme]
}

struct Meme: Identifiable, Codable {
    let id: String
    let name: String
    let url: String
    let width: Int
    let height: Int
    let box_count: Int
    let captions: Int
}
