import Foundation
import Hummingbird
import Logging

func buildApplication(
  entryPoint: App
) async throws -> some ApplicationProtocol {
  let environment = Environment()
  let router = Router()

  router.addRoutes(
    AppleAppSiteAssosiationRouter(
      appIds: [environment.get("APPLE_APP_ID")!]
    ).build()
  )

  return Application(
    router: router,
    configuration: .init(
      address: .hostname(
        entryPoint.hostname,
        port: entryPoint.port
      )
    ),
    eventLoopGroupProvider: .shared(.singletonMultiThreadedEventLoopGroup),
    logger: Logger(label: "Server")
  )
}
