import Foundation
import MySQL

final class Account : Codable {
    
    enum AccountType : UInt8, Codable, CaseIterable, ReflectionDecodable {
        case personal = 1
        case organization = 2
    }
    
    enum AccountAuthority : UInt8, Codable, CaseIterable, ReflectionDecodable {
        case normal = 1
        case elevated = 2
        case admin = 3
        case owner = 4
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
        createdAt: Int64 = 0,
        updatedAt: Int64 = 0
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
    
    private enum CodingKeys : String, CodingKey {
        case ID = "id"
        case name = "name"
        case ownerName = "owner_name"
        case email = "email"
        case phashed = "phashed"
        case type = "type"
        case authority = "authority"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
}

// safe modifiers
extension Account {
    
    func tryWithChangedID(_ newID: Int) -> Account {
        let ID: Int
        if let oldID = self.ID {
            ID = oldID
        } else {
            ID = newID
        }
        
        return Account(
            ID: ID,
            name: self.name,
            ownerName: self.ownerName,
            email: self.email,
            phashed: self.phashed,
            type: self.type,
            authority: self.authority,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
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
    
    func withCurrentCreateTime(_ timeProvider: TimeProvider) -> Account {
        return Account(
            ID: self.ID,
            name: self.name,
            ownerName: self.ownerName,
            email: self.email,
            phashed: self.phashed,
            type: self.type,
            authority: self.authority,
            createdAt: timeProvider.epochMillis(),
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
