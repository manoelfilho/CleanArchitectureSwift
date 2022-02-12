import Foundation

public extension Data {
    //método que retorna qualquer tipo (T) e esse T DEVE implementar Decodable
    public func toModel<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}
