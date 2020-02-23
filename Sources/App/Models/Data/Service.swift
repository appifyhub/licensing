import Foundation

struct Service : Hashable {
    
    let ID: Int
    let name: String
    let createdAt: Int64
    let updatedAt: Int64
    
    func withChangedName(_ newName: String) -> Service {
        return Service(
            ID: ID,
            name: newName,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
    
    func withCurrentUpdateTime(_ timeProvider: TimeProvider) -> Service {
        return Service(
            ID: ID,
            name: name,
            createdAt: createdAt,
            updatedAt: timeProvider.epochMillis()
        )
    }
    
}

extension Service : Comparable {
    
    static func < (lhs: Service, rhs: Service) -> Bool {
        return lhs.ID < rhs.ID
    }
    
    static func <= (lhs: Service, rhs: Service) -> Bool {
        return lhs.ID <= rhs.ID
    }
    
    static func >= (lhs: Service, rhs: Service) -> Bool {
        return lhs.ID >= rhs.ID
    }
    
    static func > (lhs: Service, rhs: Service) -> Bool {
        return lhs.ID > rhs.ID
    }
    
}
