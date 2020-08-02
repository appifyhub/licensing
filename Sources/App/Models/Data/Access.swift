import Foundation

final class Access : Codable {
    
    let token: String?
    let accountID: Int
    let createdAt: Int64
    
    init(token: String? = nil, accountID: Int, createdAt: Int64) {
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
    
    func tryWithChangedToken(_ newToken: String) -> Access {
        let token: String
        if let oldToken = self.token {
            token = oldToken
        } else {
            token = newToken
        }

        return Access(
            token: token,
            accountID: self.accountID,
            createdAt: self.createdAt
        )
    }

    func withCurrentCreateTime(_ timeProvider: TimeProvider) -> Access {
        return Access(
            token: self.token,
            accountID: self.accountID,
            createdAt: timeProvider.epochMillis()
        )
    }
    
}

extension Access : Comparable {
    
    static func == (lhs: Access, rhs: Access) -> Bool {
        return lhs.token == rhs.token &&
            lhs.accountID == rhs.accountID
    }

    static func < (lhs: Access, rhs: Access) -> Bool {
        return lhs.token! < rhs.token!
    }
    
    static func <= (lhs: Access, rhs: Access) -> Bool {
        return lhs.token! <= rhs.token!
    }
    
    static func >= (lhs: Access, rhs: Access) -> Bool {
        return lhs.token! >= rhs.token!
    }
    
    static func > (lhs: Access, rhs: Access) -> Bool {
        return lhs.token! > rhs.token!
    }
    
}
