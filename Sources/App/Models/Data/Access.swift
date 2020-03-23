import Foundation

struct Access : Hashable {
    
    let token: String
    let accountID: Int
    let createdAt: Int64
    
    func withChangedToken(_ newToken: String) -> Access {
        return Access(
            token: newToken,
            accountID: accountID,
            createdAt: createdAt
        )
    }
    
}

extension Access : Comparable {
    
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
