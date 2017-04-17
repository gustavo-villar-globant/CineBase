import Foundation

enum NetworkResult<Value> {
    case success(Value)
    case failure(Error)
    
    var value: Value? {
        guard case .success(let value) = self else { return nil }
        return value
    }
    var error: Error? {
        guard case .failure(let error) = self else { return nil }
        return error
    }
}
