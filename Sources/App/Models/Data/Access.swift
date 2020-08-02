import Foundation

final class Access : Codable {
    
    let token: String
    let accountID: Int
    let createdAt: Int64
    
    init(token: String, accountID: Int, createdAt: Int64) {
        self.token = token
        self.accountID = accountID
        self.createdAt = createdAt
    }
    
    private enum CodingKeys : String, CodingKey {
        case token = "token"
        case accountID = "account_id"
        case createdAt = "created_at"
    }
    
}

// safe modifiers
extension Access {
    
    func withChangedToken(_ newToken: String) -> Access {
        return Access(
            token: newToken,
            accountID: self.accountID,
            createdAt: self.createdAt
        )
    }
    
}

extension Access : Comparable {
    
    static func == (lhs: Access, rhs: Access) -> Bool {
        return lhs.token == rhs.token &&
            lhs.accountID == rhs.accountID
    }

    static func < (lhs: Access, rhs: Access) -> Bool {
        return lhs.token < rhs.token
    }
    
    static func <= (lhs: Access, rhs: Access) -> Bool {
        return lhs.token <= rhs.token
    }
    
    static func >= (lhs: Access, rhs: Access) -> Bool {
        return lhs.token >= rhs.token
    }
    
    static func > (lhs: Access, rhs: Access) -> Bool {
        return lhs.token > rhs.token
    }
    
}
