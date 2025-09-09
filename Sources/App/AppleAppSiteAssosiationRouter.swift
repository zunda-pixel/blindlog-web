import Hummingbird

struct WebCredentialBody: Codable, ResponseGenerator {
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
  
  struct WebCredential: Codable {
    let apps: [String]
  }

  var webcredentials: WebCredential
}

struct AppleAppSiteAssosiationRouter<Context: RequestContext> {
  var appIds: [String]

  func build() -> RouteCollection<Context> {
    return RouteCollection(context: Context.self)
      .get("/.well-known/apple-app-site-association") { request, context in
        let credential = WebCredentialBody(webcredentials: .init(apps: appIds))
        return credential
      }
  }
}
