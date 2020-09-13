import Foundation

extension ConfiguredProperty : HasCacheKey {
    var cacheKey: AnyHashable {
        AnyHashable(ID ?? 0)
    }
}

/// This can't be a protocol because associatedTypes are nonsense.
class IConfiguredPropertyCache : ICache<ConfiguredProperty> { }
