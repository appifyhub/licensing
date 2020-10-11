import Foundation

private let INVALID_INT = -1

extension ServiceDbm {
    
    func toDomainModel() -> Service {
        return Service(
            ID: self.ID ?? INVALID_INT,
            name: self.name,
            description: self.description,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
}

extension Service {
    
    func toStorageModel() -> ServiceDbm {
        return ServiceDbm(
            ID: self.ID,
            name: self.name,
            description: self.description,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func toNetworkModel() -> ServiceDto {
        return ServiceDto(
            id: self.ID,
            name: self.name,
            description: self.description,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt,
            properties: self.properties.map { property in property.toNetworkModel() }
        )
    }
    
}

extension ServiceDto {
    
    func toDomainModel() -> Service {
        return Service(
            ID: self.id,
            name: self.name,
            description: self.description,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt,
            properties: self.properties.map { property in property.toDomainModel() }
        )
    }
    
}
