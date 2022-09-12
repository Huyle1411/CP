import Foundation
import SwiftUI
import Combine

enum APIState {
    case loading
    case success
    case failure(String)
}

class ContestListViewModel: ObservableObject {

    var components: URLComponents?

    func composeURL() {
        var resultURL = URLComponents(string: "https://clist.by:443/api/v2/contest")
        resultURL?.queryItems = [
            URLQueryItem(name: "username", value: "Bingoblin"),
            URLQueryItem(name: "api_key", value: "2ca91832af218083a3e9ac413cdb2bbd4614e887"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "upcomming", value: "true"),
//            URLQueryItem(name: "start_time__during", value: "864000"),
            URLQueryItem(name: "order_by", value: "-start"),
            URLQueryItem(name: "limit", value: "150"),
//            URLQueryItem(name: "offset", value: "100"),
            //            URLQueryItem(name: "offset", value: "0"),
            // URLQueryItem(name: "host", value: "codeforces.com"),
//            URLQueryItem(name: "format_time", value: "true")
        ]

        components = resultURL
    }

    @Published var contests: [Contest] = []
    
    @Published var apiState: APIState = .loading
    
    init() {
        //loadAPI()
    }
    
    //API
    func loadAPI() {
        composeURL()
        // guard let url = URL(string: urlString) else {
        guard let url = components?.url else {
            apiState = .failure("URL Error")
            return
        }
        
        apiState = .loading
        
        URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
            guard let data = data else {
                print("Data Error...")
                apiState = .failure("Data Error")
                return
            }
            if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
                print(JSONString)
            }
            do {
                let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                DispatchQueue.main.async {
                    self.contests = decodedResponse.objects
                    self.apiState = .success
                }
            } catch {
                print(error)
                apiState = .failure(error.localizedDescription)
            }
        }.resume()
    }
}
