import Hummingbird
import Logging

/// Application arguments protocol. We use a protocol so we can call
/// `buildApplication` inside Tests as well as in the App executable.
/// Any variables added here also have to be added to `App` in App.swift and
/// `TestArguments` in AppTest.swift
public protocol AppArguments {
  var hostname: String { get }
  var port: Int { get }
  var logLevel: Logger.Level? { get }
}

// Request context used by application
typealias AppRequestContext = BasicRequestContext

///  Build application
/// - Parameter arguments: application arguments
public func buildApplication(_ arguments: some AppArguments) async throws
  -> some ApplicationProtocol
{
  let environment = Environment()
  let logger = {
    var logger = Logger(label: "App")
    logger.logLevel =
      arguments.logLevel ?? environment.get("LOG_LEVEL").flatMap { Logger.Level(rawValue: $0) }
      ?? .info
    return logger
  }()
  let router = try buildRouter()
  let app = Application(
    router: router,
    configuration: .init(
      address: .hostname(arguments.hostname, port: arguments.port),
      serverName: "App"
    ),
    logger: logger
  )
  return app
}

/// Build router
func buildRouter() throws -> Router<AppRequestContext> {
  let router = Router(context: AppRequestContext.self)
  // Add middleware
  router.addMiddleware {
    // logging middleware
    LogRequestsMiddleware(.info)
  }
  // Add default endpoint
  router.get("/") { _, _ in
    return "Hello!"
  }
  
  router.get("/.well-known/apple-app-site-association") { _, _ in
    WebCredentials(webcredentials: .init(apps: ["S39RJQ2UDF.com.blindlog.BlindLog"]))
  }
  return router
}

struct WebCredentials: Codable, ResponseGenerator {
  var webcredentials: WebCredential
  
  struct WebCredential: Codable {
    let apps: [String]
  }
  
  func response(
    from request: HummingbirdCore.Request,
    context: some Hummingbird.RequestContext
  ) throws -> HummingbirdCore.Response {
    try context.responseEncoder.encode(
      self,
      from: request,
      context: context
    )
  }
}
