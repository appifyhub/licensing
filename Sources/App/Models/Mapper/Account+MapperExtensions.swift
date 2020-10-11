import Foundation

private let INVALID_INT = -1
private let EMPTY_STRING = "<empty>"

// Account conversions

extension AccountDbm {
    
    func toDomainModel() -> Account {
        return Account(
            ID: self.ID ?? INVALID_INT,
            name: self.name,
            ownerName: self.ownerName,
            email: self.email,
            phashed: self.phashed,
            type: self.type.toDomainType(),
            authority: self.authority.toDomainType(),
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
}

extension Account {
    
    func toStorageModel() -> AccountDbm {
        return AccountDbm(
            ID: self.ID,
            name: self.name,
            ownerName: self.ownerName,
            email: self.email,
            phashed: self.phashed,
            type: self.type.toStorageType(),
            authority: self.authority.toStorageType(),
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func toNetworkModel() -> AccountDto {
        return AccountDto(
            id: self.ID,
            name: self.name,
            ownerName: self.ownerName,
            email: self.email,
            type: self.type.toString(),
            authority: self.authority.toString(),
            createdAt: self.createdAt,
            updatedAt: self.updatedAt,
            projects: self.projects.map { project in project.toNetworkModel() }
        )
    }
    
}

extension AccountDto {
    
    func toDomainModel() -> Account {
        return Account(
            ID: self.id,
            name: self.name,
            ownerName: self.ownerName,
            email: self.email,
            phashed: EMPTY_STRING,
            type: Account.AccountType.find(self.type),
            authority: Account.AccountAuthority.find(self.authority),
            createdAt: self.createdAt,
            updatedAt: self.updatedAt,
            projects: self.projects.map { project in project.toDomainModel() }
        )
    }
    
}

// AccountType conversions

extension AccountDbm.AccountType {
    
    func toDomainType() -> Account.AccountType {
        switch self {
            case .personal: return .personal
            case .organization: return .organization
        }
    }
    
}

extension Account.AccountType {
    
    static func find(
        _ stringValue: String,
        default: Account.AccountType = .personal
    ) -> Account.AccountType {
        switch stringValue {
            case "personal": return .personal
            case "organization": return .organization
            default: return `default`
        }
    }
    
    func toStorageType() -> AccountDbm.AccountType {
        switch self {
            case .personal: return .personal
            case .organization: return .organization
        }
    }
    
    func toString() -> String {
        switch self {
            case .personal: return "personal"
            case .organization: return "organization"
        }
    }
    
}

// AccountAuthority conversions

extension AccountDbm.AccountAuthority {
    
    func toDomainType() -> Account.AccountAuthority {
        switch self {
            case .normal: return .normal
            case .elevated: return .elevated
            case .admin: return .admin
            case .owner: return .owner
        }
    }
    
}

extension Account.AccountAuthority {
    
    static func find(
        _ stringValue: String,
        default: Account.AccountAuthority = .normal
    ) -> Account.AccountAuthority {
        switch stringValue {
            case "normal": return .normal
            case "elevated": return .elevated
            case "admin": return .admin
            case "owner": return .owner
            default: return `default`
        }
    }
    
    func toStorageType() -> AccountDbm.AccountAuthority {
        switch self {
            case .normal: return .normal
            case .elevated: return .elevated
            case .admin: return .admin
            case .owner: return .owner
        }
    }
    
    func toString() -> String {
        switch self {
            case .normal: return "normal"
            case .elevated: return "elevated"
            case .admin: return "admin"
            case .owner: return "owner"
        }
    }
    
}
