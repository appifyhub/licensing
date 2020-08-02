import Foundation

extension Access : HasCacheKey {
    var cacheKey: AnyHashable {
        AnyHashable(token ?? "invalid")
    }
}

/// This can't be a protocol because associatedTypes are nonsense.
class IAccessCache : ICache<Access> { }
