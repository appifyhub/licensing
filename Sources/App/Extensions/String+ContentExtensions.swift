import Foundation

extension String : Error {
    
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
