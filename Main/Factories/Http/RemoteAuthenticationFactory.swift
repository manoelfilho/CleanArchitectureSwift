import Foundation
import Data
import Domain

func makeRemoteAuthentication() -> Authentication {
    return makeRemoteAuthenticationWith(httpClient: makeAlamofireAdapter())
}

func makeRemoteAuthenticationWith(httpClient: HttpPostClient) -> Authentication {
    let remoteAuthentication = RemoteAuthentication(url: makeApiUrl(path: "authenticate"), httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteAuthentication)
}
