import Foundation

struct Project {
    
    enum ProjectType : UInt8, CaseIterable {
        case opensource = 1
        case commercial = 2
        case free = 3
    }
    
    enum ProjectStatus : UInt8, CaseIterable {
        case review = 1
        case active = 2
        case blocked = 3
        case suspended = 4
    }
    
    var ID: Int
    var name: String
    var type: ProjectType
    var status: ProjectStatus
    var createdAt: Int64
    var updatedAt: Int64
    
    var assignedServices: [AssignedService] = []
    
}

extension Project : Comparable {
    
    static func == (lhs: Project, rhs: Project) -> Bool {
        return lhs.ID == rhs.ID
    }
    
    static func < (lhs: Project, rhs: Project) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func <= (lhs: Project, rhs: Project) -> Bool {
        return lhs.name <= rhs.name
    }
    
    static func >= (lhs: Project, rhs: Project) -> Bool {
        return lhs.name >= rhs.name
    }
    
    static func > (lhs: Project, rhs: Project) -> Bool {
        return lhs.name > rhs.name
    }
    
}
