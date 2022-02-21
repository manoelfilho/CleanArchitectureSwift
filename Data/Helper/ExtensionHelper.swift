import Foundation

public extension Data {
    //método que retorna qualquer tipo (T) e esse T DEVE implementar Decodable
    func toModel<T: Decodable>() -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: self)
        } catch {
            print(">>>")
            print(error.localizedDescription)
            print(">>>")
        }
        return nil
    }
    
    func toJson() -> [String: Any]? {
        return try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: Any]
    }
}
