import Foundation
import Domain

public final class RemoteAuthentication {
    
    private let url: URL
    private let httpClient: HttpPostClient
    
    public init(url: URL, httpClient: HttpPostClient){
        self.url = url
        self.httpClient = httpClient
    }
    
    public func authenticate() {
        httpClient.post(to: self.url, with: nil) { _ in }
    }
    
}
