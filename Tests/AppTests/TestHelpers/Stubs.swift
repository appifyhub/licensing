import Foundation

@testable import App

extension Access {
    
    static func stubStorage() -> AccessDbm {
        return AccessDbm(token: "token", accountID: 1, createdAt: 10)
    }
    
    static func stub() -> Access {
        return Access(token: "token", createdAt: 10)
    }
    
    static func stubNetwork() -> AccessDto {
        return AccessDto(value: "token", createdAt: 10)
    }
    
}

extension Account {
    
    static func stubStorage() -> AccountDbm {
        return AccountDbm(ID: 1, name: "name", ownerName: "ownerName", email: "email", phashed: "phashed", type: .personal, authority: .normal, createdAt: 10, updatedAt: 20)
    }
    
    static func stub() -> Account {
        return Account(ID: 1, name: "name", ownerName: "ownerName", email: "email", phashed: "phashed", type: .personal, authority: .normal, createdAt: 10, updatedAt: 20, accesses: [Access.stub()], projects: [Project.stub()])
    }
    
    static func stubNetwork() -> AccountDto {
        return AccountDto(id: 1, name: "name", ownerName: "ownerName", email: "email", type: "personal", authority: "normal", createdAt: 10, updatedAt: 20, projects: [Project.stubNetwork()])
    }
    
}

extension AssignedService {
    
    static func stubStorage() -> AssignedServiceDbm {
        return AssignedServiceDbm(ID: 1, projectID: 1, serviceID: 1, assignedAt: 10)
    }
    
    static func stub() -> AssignedService {
        return AssignedService(ID: 1, assignedAt: 10, configuredProperties: [ConfiguredProperty.stub()])
    }
    
    static func stubNetwork() -> AssignedServiceDto {
        return AssignedServiceDto(id: 1, assignedAt: 10, configuredProperties: [ConfiguredProperty.stubNetwork()])
    }
    
}

extension ConfiguredProperty {
    
    static func stubStorage() -> ConfiguredPropertyDbm {
        return ConfiguredPropertyDbm(ID: 1, assignedServiceID: 1, propertyID: 1, value: "value", createdAt: 10, updatedAt: 20)
    }
    
    static func stub() -> ConfiguredProperty {
        return ConfiguredProperty(ID: 1, value: "value", createdAt: 10, updatedAt: 20)
    }
    
    static func stubNetwork() -> ConfiguredPropertyDto {
        return ConfiguredPropertyDto(id: 1, value: "value", createdAt: 10, updatedAt: 20)
    }
    
}

extension Project {
    
    static func stubStorage() -> ProjectDbm {
        return ProjectDbm(ID: 1, accountID: 1, name: "name", type: .commercial, status: .review, createdAt: 10, updatedAt: 20)
    }
    
    static func stub() -> Project {
        return Project(ID: 1, name: "name", type: .commercial, status: .review, createdAt: 10, updatedAt: 20, assignedServices: [AssignedService.stub()])
    }
    
    static func stubNetwork() -> ProjectDto {
        return ProjectDto(id: 1, name: "name", type: "commercial", status: "review", createdAt: 10, updatedAt: 20, assignedServices: [AssignedService.stubNetwork()])
    }
    
}

extension Property {
    
    static func stubStorage() -> PropertyDbm {
        return PropertyDbm(ID: 1, serviceID: 1, name: "name", type: .string, mandatory: true, createdAt: 10, updatedAt: 20)
    }
    
    static func stub() -> Property {
        return Property(ID: 1, name: "name", type: .string, mandatory: true, createdAt: 10, updatedAt: 20)
    }
    
    static func stubNetwork() -> PropertyDto {
        return PropertyDto(id: 1, name: "name", type: "string", mandatory: true, createdAt: 10, updatedAt: 20)
    }
    
}

extension Service {
    
    static func stubStorage() -> ServiceDbm {
        return ServiceDbm(ID: 1, name: "name", description: "description", createdAt: 10, updatedAt: 20)
    }
    
    static func stub() -> Service {
        return Service(ID: 1, name: "name", description: "description", createdAt: 10, updatedAt: 20, assignedServices: [AssignedService.stub()], properties: [Property.stub()])
    }
    
    static func stubNetwork() -> ServiceDto {
        return ServiceDto(id: 1, name: "name", description: "description", createdAt: 10, updatedAt: 20, properties: [Property.stubNetwork()])
    }
    
}
