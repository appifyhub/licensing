import Foundation

struct ConfiguredProperty {

    var ID: Int
    var value: String // storing all as String for simplicity
    var createdAt: Int64
    var updatedAt: Int64

}

extension ConfiguredProperty : Comparable {
    
    static func == (lhs: ConfiguredProperty, rhs: ConfiguredProperty) -> Bool {
        return lhs.ID == rhs.ID
    }
    
    static func < (lhs: ConfiguredProperty, rhs: ConfiguredProperty) -> Bool {
        return lhs.value < rhs.value
    }
    
    static func <= (lhs: ConfiguredProperty, rhs: ConfiguredProperty) -> Bool {
        return lhs.value <= rhs.value
    }
    
    static func >= (lhs: ConfiguredProperty, rhs: ConfiguredProperty) -> Bool {
        return lhs.value >= rhs.value
    }
    
    static func > (lhs: ConfiguredProperty, rhs: ConfiguredProperty) -> Bool {
        return lhs.value > rhs.value
    }
    
}
