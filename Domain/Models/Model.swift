import Foundation

public protocol Model: Codable, Equatable {}


//Registrar as extensoes de todos os models
public extension Model {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
