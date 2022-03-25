import Foundation

func makeApiUrl(path: String) -> URL{
    return URL(string: "\(Enviroment.variable(.apiBaseUrl))/\(path)")!
}
