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
            if viewModel.trending.isEmpty{
                Text("No Results")
            } else{
                ScrollView(.horizontal){
                    HStack{
                        ForEach(viewModel.trending){
                            trendingItem in
                            TrendingCard(trendingItem: trendingItem)
                        }
                    }
                }
            }
        }
        .padding().onAppear{
            viewModel.loadTrending()
        }
    }
}
// creating a component
struct TrendingCard: View{
    let trendingItem: TrendingItem
    var body: some View{
        ZStack{
//            AsyncImage(url: trendingItem.poster_path )
//            {image in image.resizable().scaledToFill()
//
//            } placeholder: {
//                ProgressView()
//            }
            VStack{
                HStack{
                    Text(trendingItem.title)
                    Spacer()
                    Image(systemName: "heart.fill").foregroundColor(.red)
                }
                HStack{
                    Image(systemName: "hand.thumbsup.fill").foregroundColor(.yellow)
                    Text("\(trendingItem.vote_average)")
                }.foregroundColor(.yellow)
            }
        }
    }
}
@MainActor
class MovieDBViewModel: ObservableObject{
    @Published var trending:[TrendingItem] = []
    static let apiKey = "b5f9b02d0f5d57d2f87ea214b56f63af"
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNWY5YjAyZDBmNWQ1N2QyZjg3ZWEyMTRiNTZmNjNhZiIsInN1YiI6IjYwY2RmNmUwMGE5NGQ0MDA3OTQ4MDQ2NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.AkIA0pXmG8FK9IYOgM2gIJwPhISz-papJpv5Y-RuU4E"
    //https://api.themoviedb.org/3/movie/day?api_key=b5f9b02d0f5d57d2f87ea214b56f63af
    func loadTrending(){
        Task{
            let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(MovieDBViewModel.apiKey)")!
            do{
                let(data, _) = try await URLSession.shared.data(from: url)
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                trending = trendingResults.results
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}

struct TrendingResults: Decodable{
    let page: Int
    let results: [TrendingItem]
    let total_pages: Int
    let total_results: Int
}

struct TrendingItem: Identifiable, Decodable{
    let adult: Bool
    let id: Int
    let poster_path: String
    let title: String
    let vote_average: Float
    let backdrop_path: String
    
    var backdropURL : URL {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")
        return baseURL?.appending(path: backdrop_path)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
