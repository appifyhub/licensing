import Foundation

extension Optional where Wrapped == String {
    
    func isNullOrBlank() -> Bool {
        return self.wrapped == nil || self.unsafelyUnwrapped.isBlank()
    }
    
    func isNotNullNorBlank() -> Bool {
        return !self.isNullOrBlank()
    }
    
}
