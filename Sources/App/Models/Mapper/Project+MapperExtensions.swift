import Foundation

private let INVALID_INT = -1

// Project conversions

extension ProjectDbm {
    
    func toDomainModel() -> Project {
        return Project(
            ID: self.ID ?? INVALID_INT,
            name: self.name,
            type: self.type.toDomainType(),
            status: self.status.toDomainType(),
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
}

extension Project {
    
    func toStorageModel(forAccount: Account) -> ProjectDbm {
        return ProjectDbm(
            ID: self.ID,
            accountID: forAccount.ID,
            name: self.name,
            type: self.type.toStorageType(),
            status: self.status.toStorageType(),
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func toNetworkModel() -> ProjectDto {
        return ProjectDto(
            id: self.ID,
            name: self.name,
            type: self.type.toString(),
            status: self.status.toString(),
            createdAt: self.createdAt,
            updatedAt: self.updatedAt,
            assignedServices: self.assignedServices.map { assignedService in assignedService.toNetworkModel() }
        )
    }
    
}

extension ProjectDto {
    
    func toDomainModel() -> Project {
        return Project(
            ID: self.id,
            name: self.name,
            type: Project.ProjectType.find(self.type),
            status: Project.ProjectStatus.find(self.status),
            createdAt: self.createdAt,
            updatedAt: self.updatedAt,
            assignedServices: self.assignedServices.map { assignedService in assignedService.toDomainModel() }
        )
    }
    
}

// ProjectStatus conversions

extension ProjectDbm.ProjectStatus {
    
    func toDomainType() -> Project.ProjectStatus {
        switch self {
            case .review: return .review
            case .active: return .active
            case .blocked: return .blocked
            case .suspended: return .suspended
        }
    }
    
}

extension Project.ProjectStatus {
    
    static func find(
        _ stringValue: String,
        default: Project.ProjectStatus = .review
    ) -> Project.ProjectStatus {
        switch stringValue {
            case "review": return .review
            case "active": return .active
            case "blocked": return .blocked
            case "suspended": return .suspended
            default: return `default`
        }
    }
    
    func toStorageType() -> ProjectDbm.ProjectStatus {
        switch self {
            case .review: return .review
            case .active: return .active
            case .blocked: return .blocked
            case .suspended: return .suspended
        }
    }
    
    func toString() -> String {
        switch self {
            case .review: return "review"
            case .active: return "active"
            case .blocked: return "blocked"
            case .suspended: return "suspended"
        }
    }
    
}

// ProjectType conversions

extension ProjectDbm.ProjectType {
    
    func toDomainType() -> Project.ProjectType {
        switch self {
            case .opensource: return .opensource
            case .commercial: return .commercial
            case .free: return .free
        }
    }
    
}

extension Project.ProjectType {
    
    static func find(
        _ stringValue: String,
        default: Project.ProjectType = .commercial
    ) -> Project.ProjectType {
        switch stringValue {
            case "opensource": return .opensource
            case "commercial": return .commercial
            case "free": return .free
            default: return `default`
        }
    }
    
    func toStorageType() -> ProjectDbm.ProjectType {
        switch self {
            case .opensource: return .opensource
            case .commercial: return .commercial
            case .free: return .free
        }
    }
    
    func toString() -> String {
        switch self {
            case .opensource: return "opensource"
            case .commercial: return "commercial"
            case .free: return "free"
        }
    }
    
}
