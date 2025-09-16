import Hummingbird
import HummingbirdTesting
import Logging
import Testing

@testable import App

@Suite
struct AppTests {
  struct TestArguments: AppArguments {
    let hostname = "127.0.0.1"
    let port = 0
    let logLevel: Logger.Level? = .trace
  }

  @Test("App responds with expected greeting")
  func appRespondsWithGreeting() async throws {
    let args = TestArguments()
    let app = try await buildApplication(args)
    try await app.test(.router) { client in
      try await client.execute(uri: "/", method: .get) { response in
        #expect(response.body == ByteBuffer(string: "Hello!"))
      }
    }
  }
}
