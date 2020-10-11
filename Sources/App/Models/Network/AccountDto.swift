import Foundation
import Vapor

struct AccountDto : Content {
    
    let id: Int
    let name: String
    let ownerName: String
    let email: String
    let type: String // personal, organization
    let authority: String // normal, elevated, admin, owner
    let createdAt: Int64
    let updatedAt: Int64
    
    let projects: [ProjectDto]
    
}

extension AccountDto : Comparable {
    
    static func == (lhs: AccountDto, rhs: AccountDto) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: AccountDto, rhs: AccountDto) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func <= (lhs: AccountDto, rhs: AccountDto) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func >= (lhs: AccountDto, rhs: AccountDto) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func > (lhs: AccountDto, rhs: AccountDto) -> Bool {
        return lhs.id == rhs.id
    }
    
}
