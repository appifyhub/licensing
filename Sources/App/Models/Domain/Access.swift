import Foundation

struct Access {
    
    var token: String
    var createdAt: Int64
    
}

extension Access : Comparable {
    
    static func == (lhs: Access, rhs: Access) -> Bool {
        return lhs.token == rhs.token &&
            lhs.createdAt == rhs.createdAt
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
