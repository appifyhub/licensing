import Foundation

private let INVALID_INT = -1

extension ConfiguredPropertyDbm {
    
    func toDomainModel() -> ConfiguredProperty {
        return ConfiguredProperty(
            ID: self.ID ?? INVALID_INT,
            value: self.value,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
}

extension ConfiguredProperty {
    
    func toStorageModel(
        forAssignedService: AssignedService,
        forProperty: Property
    ) -> ConfiguredPropertyDbm {
        return ConfiguredPropertyDbm(
            ID: self.ID,
            assignedServiceID: forAssignedService.ID,
            propertyID: forProperty.ID,
            value: self.value,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func toNetworkModel() -> ConfiguredPropertyDto {
        return ConfiguredPropertyDto(
            id: self.ID,
            value: self.value,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
}

extension ConfiguredPropertyDto {
    
    func toDomainModel() -> ConfiguredProperty {
        return ConfiguredProperty(
            ID: self.id,
            value: self.value,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
}
