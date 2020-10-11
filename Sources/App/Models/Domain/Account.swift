import Foundation

struct Account {
    
    enum AccountType : UInt8, CaseIterable {
        case personal = 1
        case organization = 2
    }
    
    enum AccountAuthority : UInt8, CaseIterable {
        case normal = 1
        case elevated = 2
        case admin = 3
        case owner = 4
    }
    
    var ID: Int
    var name: String
    var ownerName: String
    var email: String
    var phashed: String
    var type: AccountType
    var authority: AccountAuthority
    var createdAt: Int64
    var updatedAt: Int64
    
    var accesses: [Access] = []
    var projects: [Project] = []
    
}

extension Account : Comparable {
    
    static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.ID == rhs.ID
    }
    
    static func < (lhs: Account, rhs: Account) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func <= (lhs: Account, rhs: Account) -> Bool {
        return lhs.name <= rhs.name
    }
    
    static func >= (lhs: Account, rhs: Account) -> Bool {
        return lhs.name >= rhs.name
    }
    
    static func > (lhs: Account, rhs: Account) -> Bool {
        return lhs.name > rhs.name
    }
    
}
