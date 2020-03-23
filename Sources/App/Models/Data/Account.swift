import Foundation

struct Account : Hashable {
    
    enum AccountType : Int {
        case personal
        case organization
    }
    
    enum AccountAuthority : Int {
        case normal
        case elevated
        case admin
        case owner
    }
    
    let ID: Int
    let name: String
    let ownerName: String
    let email: String
    let phashed: String
    let type: AccountType
    let authority: AccountAuthority
    let createdAt: Int64
    let updatedAt: Int64
    
    func withChangedName(_ newName: String) -> Account {
        return Account(
            ID: ID,
            name: newName,
            ownerName: ownerName,
            email: email,
            phashed: phashed,
            type: type,
            authority: authority,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
    
    func withChangedOwnerName(_ newOwnerName: String) -> Account {
        return Account(
            ID: ID,
            name: name,
            ownerName: newOwnerName,
            email: email,
            phashed: phashed,
            type: type,
            authority: authority,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
    
    func withChangedEmail(_ newEmail: String) -> Account {
        return Account(
            ID: ID,
            name: name,
            ownerName: ownerName,
            email: newEmail,
            phashed: phashed,
            type: type,
            authority: authority,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
    
    func withChangedPasswordHash(_ newPasswordHash: String) -> Account {
        return Account(
            ID: ID,
            name: name,
            ownerName: ownerName,
            email: email,
            phashed: newPasswordHash,
            type: type,
            authority: authority,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
    
    func withChangedType(_ newType: AccountType) -> Account {
        return Account(
            ID: ID,
            name: name,
            ownerName: ownerName,
            email: email,
            phashed: phashed,
            type: newType,
            authority: authority,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
    
    func withChangedAuthority(_ newAuthority: AccountAuthority) -> Account {
        return Account(
            ID: ID,
            name: name,
            ownerName: ownerName,
            email: email,
            phashed: phashed,
            type: type,
            authority: newAuthority,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
    
    func withCurrentUpdateTime(_ timeProvider: TimeProvider) -> Account {
        return Account(
            ID: ID,
            name: name,
            ownerName: ownerName,
            email: email,
            phashed: phashed,
            type: type,
            authority: authority,
            createdAt: createdAt,
            updatedAt: timeProvider.epochMillis()
        )
    }
    
}

extension Account : Comparable {
    
    static func < (lhs: Account, rhs: Account) -> Bool {
        return lhs.ID < rhs.ID
    }
    
    static func <= (lhs: Account, rhs: Account) -> Bool {
        return lhs.ID <= rhs.ID
    }
    
    static func >= (lhs: Account, rhs: Account) -> Bool {
        return lhs.ID >= rhs.ID
    }
    
    static func > (lhs: Account, rhs: Account) -> Bool {
        return lhs.ID > rhs.ID
    }
    
}
