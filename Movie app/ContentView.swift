//
//  ContentView.swift
//  Movie app
//
//  Created by GB on 9/26/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MovieDBViewModel()
    var body: some View {
        VStack {
           
        }
        .padding().onAppear{
            viewModel.loadTrending()
        }
    }
}
@MainActor
class MovieDBViewModel: ObservableObject{
    @Published var homeScreen:[TrendingItem] = []
    static let apiKey = "b5f9b02d0f5d57d2f87ea214b56f63af"
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNWY5YjAyZDBmNWQ1N2QyZjg3ZWEyMTRiNTZmNjNhZiIsInN1YiI6IjYwY2RmNmUwMGE5NGQ0MDA3OTQ4MDQ2NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.AkIA0pXmG8FK9IYOgM2gIJwPhISz-papJpv5Y-RuU4E"
    //https://api.themoviedb.org/3/movie/day?api_key=b5f9b02d0f5d57d2f87ea214b56f63af
    func loadTrending(){
        Task{
            let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(MovieDBViewModel.apiKey)")!
            do{
                let(data, response) = try await URLSession.shared.data(from: url)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}

struct TrendingItem: Identifiable, Decodable{
    let adult: Bool
    let id: Int
    let poster_path: String
    let title: String
    let vote_average: Float
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
