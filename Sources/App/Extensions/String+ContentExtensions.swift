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
