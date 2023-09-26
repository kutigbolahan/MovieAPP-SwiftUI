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
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}
class MovieDBViewModel: ObservableObject{
    @Published var homeScreen:[ TrendingItem]
    
    func
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
