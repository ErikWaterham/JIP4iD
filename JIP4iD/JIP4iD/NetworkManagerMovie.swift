import Combine
import Foundation

public class NetworkManagerMovie: ObservableObject {

    @Published public var movieDetails: Movie = Movie( // swiftlint:disable:this redundant_type_annotation unnecessary_type
        adult: false,
        backdropPath: "",
        belongsToCollection: nil,
        budget: 0,
        genres: [],
        homepage: nil,
        id: nil,
        imdbId: nil,
        originalLanguage: nil,
        originalTitle: nil,
        overview: "",
        popularity: nil,
        posterPath: nil,
        productionCompanies: [],
        productionCountries: [],
        releaseDate: "",
        revenue: nil,
        runtime: nil,
        spokenLanguages: [],
        status: nil,
        tagline: nil,
        title: "",
        video: false,
        voteAverage: nil,
        voteCount: nil,
        videos: Movie.Videos(results: [])
    )
    @Published public var loadingMovie: Bool = true

    private let apiUrlBaseBegin: String = "https://api.themoviedb.org/3/movie/"
    private let apiUrlBaseEnd: String = "?api_key=61ef4a247342ea9c8388ef6377a75a24&append_to_response=videos"

    public init() {

        loadingMovie = true
    }

    public func loadData(_ id: Int) {

        guard let url = URL(string: "\(apiUrlBaseBegin)\(id)\(apiUrlBaseEnd)") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }

            let decoder: JSONDecoder = JSONDecoder() // swiftlint:disable:this redundant_type_annotation unnecessary_type
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                let loaded = try decoder.decode(Movie.self, from: data) // swiftlint:disable:this explicit_type_interface
                DispatchQueue.main.async {
                    self.movieDetails = loaded
                    self.loadingMovie = false
                }
            } catch let jsonErr { // swiftlint:disable:this explicit_type_interface untyped_error_in_catch
                print("NetworkManagerMovie Error decoding JSON", jsonErr)
            }
            return
        }
        .resume()
    }
}
