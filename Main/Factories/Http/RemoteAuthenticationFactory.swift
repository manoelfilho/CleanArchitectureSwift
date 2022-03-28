import Foundation
import Data
import Domain

func makeRemoteAuthentication(httpClient: HttpPostClient) -> Authentication {
    let remoteAuthentication = RemoteAuthentication(url: makeApiUrl(path: "authenticate"), httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteAuthentication)
}
