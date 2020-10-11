import Foundation

extension AccessDbm {
    
    func toDomainModel() -> Access {
        return Access(
            token: self.token ?? "<invalid_random_\(Int64.random(in: 0..<Int64.max))>",
            createdAt: self.createdAt
        )
    }
    
}

extension Access {
    
    func toStorageModel(forAccount: Account) -> AccessDbm {
        return AccessDbm(
            token: self.token,
            accountID: forAccount.ID,
            createdAt: self.createdAt
        )
    }
    
    func toNetworkModel() -> AccessDto {
        return AccessDto(
            value: self.token,
            createdAt: self.createdAt
        )
    }
    
}

extension AccessDto {
    
    func toDomainModel() -> Access {
        return Access(
            token: self.value,
            createdAt: self.createdAt
        )
    }
    
}
