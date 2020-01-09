//
//  NetworkManagerMovie.swift
//  JIP4iD
//
//  Created by Erik Waterham on 07/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import Foundation
import Combine

class NetworkManagerMovie: ObservableObject {
    @Published var movieDetails = Movie(
        adult: false,
        backdropPath: "",
        belongsToCollection: nil,
        budget: 0,
        genres: [],
        homepage: nil, id: nil, imdbId: nil, originalLanguage: nil, originalTitle: nil,
        overview: "",
        popularity: nil, posterPath: nil, productionCompanies: [], productionCountries: [],
        releaseDate: "",
        revenue: nil, runtime: nil, spokenLanguages: [], status: nil, tagline: nil,
        title: "",
        video: false, voteAverage: nil, voteCount: nil,
        videos: Movie.Videos(results: [])
    )
    @Published var loadingMovie = false
    private let apiUrlBaseBegin = "https://api.themoviedb.org/3/movie/"
    private let apiUrlBaseEnd = "?api_key=61ef4a247342ea9c8388ef6377a75a24&append_to_response=videos"
    init() {
        loadingMovie = true
//        loadData()
    }

    func loadData(_ id: Int) {
        guard let url = URL(string: "\(apiUrlBaseBegin)\(id)\(apiUrlBaseEnd)") else { return }

        URLSession.shared.dataTask(with: url){ (data, _, _) in
            guard let data = data else { return }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                let loaded = try decoder.decode(Movie.self, from: data)
                DispatchQueue.main.async {
                    self.movieDetails = loaded
                    self.loadingMovie = false
                    print(loaded)
                    print("=========================================")
                    print(loaded.videos)
                    print("=========================================")
                    print(loaded.videos.results)
                    print("=========================================")
                    print(loaded.videos.results.count)
                    print("=========================================")
//                    print(loaded.videos.results[0])

                }
            } catch let jsonErr {
                print("NetworkManagerMovie Error decoding JSON", jsonErr)
            }
            return
        }.resume()
    }
}
