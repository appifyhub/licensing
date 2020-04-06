import Foundation

final class Account : Codable {
    
    enum AccountType : Int, Codable {
        case personal
        case organization
    }
    
    enum AccountAuthority : Int, Codable {
        case normal
        case elevated
        case admin
        case owner
    }
    
    let ID: Int?
    let name: String
    let ownerName: String
    let email: String
    let phashed: String
    let type: AccountType
    let authority: AccountAuthority
    let createdAt: Int64
    let updatedAt: Int64
    
    init(
        ID: Int? = nil,
        name: String,
        ownerName: String,
        email: String,
        phashed: String,
        type: AccountType,
        authority: AccountAuthority,
        createdAt: Int64,
        updatedAt: Int64
    ) {
        self.ID = ID
        self.name = name
        self.ownerName = ownerName
        self.email = email
        self.phashed = phashed
        self.type = type
        self.authority = authority
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
}

// safe modifiers
extension Account {
    
    func withChangedName(_ newName: String) -> Account {
        return Account(
            ID: self.ID,
            name: newName,
            ownerName: self.ownerName,
            email: self.email,
            phashed: self.phashed,
            type: self.type,
            authority: self.authority,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withChangedOwnerName(_ newOwnerName: String) -> Account {
        return Account(
            ID: self.ID,
            name: self.name,
            ownerName: newOwnerName,
            email: self.email,
            phashed: self.phashed,
            type: self.type,
            authority: self.authority,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withChangedEmail(_ newEmail: String) -> Account {
        return Account(
            ID: self.ID,
            name: self.name,
            ownerName: self.ownerName,
            email: newEmail,
            phashed: self.phashed,
            type: self.type,
            authority: self.authority,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withChangedPasswordHash(_ newPasswordHash: String) -> Account {
        return Account(
            ID: self.ID,
            name: self.name,
            ownerName: self.ownerName,
            email: self.email,
            phashed: newPasswordHash,
            type: self.type,
            authority: self.authority,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withChangedType(_ newType: AccountType) -> Account {
        return Account(
            ID: self.ID,
            name: self.name,
            ownerName: self.ownerName,
            email: self.email,
            phashed: self.phashed,
            type: newType,
            authority: self.authority,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withChangedAuthority(_ newAuthority: AccountAuthority) -> Account {
        return Account(
            ID: self.ID,
            name: self.name,
            ownerName: self.ownerName,
            email: self.email,
            phashed: self.phashed,
            type: self.type,
            authority: newAuthority,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withCurrentUpdateTime(_ timeProvider: TimeProvider) -> Account {
        return Account(
            ID: self.ID,
            name: self.name,
            ownerName: self.ownerName,
            email: self.email,
            phashed: self.phashed,
            type: self.type,
            authority: self.authority,
            createdAt: self.createdAt,
            updatedAt: timeProvider.epochMillis()
        )
    }
    
}

extension Account : Comparable {
    
    static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.ID == rhs.ID &&
            lhs.name == rhs.name &&
            lhs.ownerName == rhs.ownerName &&
            lhs.email == rhs.email &&
            lhs.phashed == rhs.phashed &&
            lhs.type == rhs.type &&
            lhs.authority == rhs.authority
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
