
import Foundation

enum GithubRepoEndpoint {
    case fetchGithubRepos
}

extension GithubRepoEndpoint: Endpoint {
  
  var baseUrl: String {
    return "https://api.github.com"
  }
  
  var httpMethod: HTTPMethod {
    switch self {
    case .fetchGithubRepos:
      return .get
    }
  }
  
  var path: String {
    switch self {
    case .fetchGithubRepos:
      return "/repositories"

    }
  }
  
  // This query item is required by the BandsInTown API - see documentation:
  // https://app.swaggerhub.com/apis/Bandsintown/PublicAPI/3.0.0#/
  var queryItems: [URLQueryItem]? {
    return [URLQueryItem(name: "app_id", value: "swift-network-layer-example")]
  }
  
}
