import URLRouting
import Vapor
import VaporRouting

public func configure(_ app: Application) async throws {
  app.mount(SiteRouter(), use: handleRoute(for:_:))
}

public enum SiteRoute {
  case hello
}

public struct SiteRouter: Parser {
  public var body: some Parser<URLRequestData, SiteRoute> {
    Route(.case(SiteRoute.hello)) {
      Path { "hello" }
    }
  }
}

public func handleRoute(for request: Request, _ route: SiteRoute) -> any AsyncResponseEncodable {
  switch route {
  case .hello:
    return "Oh hi there!"
  }
}
