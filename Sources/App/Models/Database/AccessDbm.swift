import Foundation

final class AccessDbm : Codable {
    
    let token: String?
    let accountID: Int
    let createdAt: Int64
    
    init(
        token: String? = nil,
        accountID: Int,
        createdAt: Int64 = 0
    ) {
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
extension AccessDbm {
    
    func tryWithChangedToken(_ newToken: String) -> AccessDbm {
        let token: String
        if let oldToken = self.token {
            token = oldToken
        } else {
            token = newToken
        }

        return AccessDbm(
            token: token,
            accountID: self.accountID,
            createdAt: self.createdAt
        )
    }

    func withCurrentCreateTime(_ timeProvider: TimeProvider) -> AccessDbm {
        return AccessDbm(
            token: self.token,
            accountID: self.accountID,
            createdAt: timeProvider.epochMillis()
        )
    }
    
}

extension AccessDbm : Comparable {
    
    static func == (lhs: AccessDbm, rhs: AccessDbm) -> Bool {
        return lhs.token == rhs.token &&
            lhs.accountID == rhs.accountID
    }

    static func < (lhs: AccessDbm, rhs: AccessDbm) -> Bool {
        return lhs.token! < rhs.token!
    }
    
    static func <= (lhs: AccessDbm, rhs: AccessDbm) -> Bool {
        return lhs.token! <= rhs.token!
    }
    
    static func >= (lhs: AccessDbm, rhs: AccessDbm) -> Bool {
        return lhs.token! >= rhs.token!
    }
    
    static func > (lhs: AccessDbm, rhs: AccessDbm) -> Bool {
        return lhs.token! > rhs.token!
    }
    
}
