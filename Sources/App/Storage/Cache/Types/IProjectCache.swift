import Foundation

extension ProjectDbm : HasCacheKey {
    var cacheKey: AnyHashable {
        AnyHashable(ID ?? 0)
    }
}

/// This can't be a protocol because associatedTypes are nonsense.
class IProjectCache : ICache<ProjectDbm> { }
