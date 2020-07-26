import Foundation

class SystemTimeProvider : TimeProvider {
    
    func epochMillis() -> Int64 {
        return Int64((Date().timeIntervalSince1970 * 1000.0).rounded())
    }
    
}

