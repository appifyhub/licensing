import Foundation

extension AccessDbm : HasCacheKey {
    var cacheKey: AnyHashable {
        AnyHashable(token ?? "invalid")
    }
}

/// This can't be a protocol because associatedTypes are nonsense.
class IAccessCache : ICache<AccessDbm> { }
