import Foundation

extension String {
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func isBlank() -> Bool {
        return self.trim().isEmpty
    }
    
    func isNotBlank() -> Bool {
        return !self.isBlank()
    }
    
}

extension Optional where Wrapped == String {
    
    func isNullOrBlank() -> Bool {
        return self.wrapped == nil || self.unsafelyUnwrapped.isBlank()
    }
    
    func isNotNullNorBlank() -> Bool {
        return !self.isNullOrBlank()
    }
    
}
