import Foundation

private let INVALID_INT = -1

extension AssignedServiceDbm {
    
    func toDomainModel() -> AssignedService {
        return AssignedService(
            ID: self.ID ?? INVALID_INT,
            assignedAt: self.assignedAt
        )
    }
    
}

extension AssignedService {
    
    func toStorageModel(
        forProject: Project,
        forService: Service
    ) -> AssignedServiceDbm {
        return AssignedServiceDbm(
            ID: self.ID,
            projectID: forProject.ID,
            serviceID: forService.ID,
            assignedAt: self.assignedAt
        )
    }
    
    func toNetworkModel() -> AssignedServiceDto {
        return AssignedServiceDto(
            id: self.ID,
            assignedAt: self.assignedAt,
            configuredProperties: self.configuredProperties.map { configuredProperty in configuredProperty.toNetworkModel() }
        )
    }
    
}

extension AssignedServiceDto {
    
    func toDomainModel() -> AssignedService {
        return AssignedService(
            ID: self.id,
            assignedAt: self.assignedAt,
            configuredProperties: self.configuredProperties.map { configuredProperty in configuredProperty.toDomainModel() }
        )
    }
    
}
