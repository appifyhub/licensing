import Foundation

extension ServiceDbm : HasCacheKey {
    var cacheKey: AnyHashable {
        AnyHashable(ID ?? 0)
    }
}

/// This can't be a protocol because associatedTypes are nonsense.
class IServiceCache : ICache<ServiceDbm> { }
