import Foundation
import Vapor

final class DI {
    
    private static var container: DI? = nil
    
    static func configure(
        _ cacheConfig: CacheConfig,
        _ persistenceConfig: PersistenceConfig,
        _ timeProvider: TimeProvider
    ) throws {
        if (container != nil) { throw "Container already initialized" }
        container = DI(cacheConfig, persistenceConfig, timeProvider)
    }
    
    static func shared() -> DI { return container! }
    
    // Container properties
    
    private let cacheConfig: CacheConfig
    private let persistenceConfig: PersistenceConfig
    private let timeProvider: TimeProvider
    private let lock = DispatchSemaphore(value: 1)
    
    // Stored instances
    
    private lazy var accountCache: IAccountCache = { return AccountInMemCache(maxSize: cacheConfig.maxStoredItems) }()
    private lazy var accessCache: IAccessCache = { return AccessInMemCache(maxSize: cacheConfig.maxStoredItems) }()
    private lazy var projectCache: IProjectCache = { return ProjectInMemCache(maxSize: cacheConfig.maxStoredItems) }()
    private lazy var serviceCache: IServiceCache = { return ServiceInMemCache(maxSize: cacheConfig.maxStoredItems) }()
    private lazy var propertyCache: IPropertyCache = { return PropertyInMemCache(maxSize: cacheConfig.maxStoredItems) }()
    
    private lazy var accountMemPersistence: IAccountPersistence = { return AccountPersistenceInMem(timeProvider: timeProvider) }()
    private lazy var accessMemPersistence: IAccessPersistence = { return AccessPersistenceInMem(timeProvider: timeProvider) }()
    private lazy var projectMemPersistence: IProjectPersistence = { return ProjectPersistenceInMem(timeProvider: timeProvider) }()
    private lazy var serviceMemPersistence: IServicePersistence = { return ServicePersistenceInMem(timeProvider: timeProvider) }()
    private lazy var propertyMemPersistence: IPropertyPersistence = { return PropertyPersistenceInMem(timeProvider: timeProvider) }()
    
    // Initializer
    
    private init(
        _ cacheConfig: CacheConfig,
        _ persistenceConfig: PersistenceConfig,
        _ timeProvider: TimeProvider
    ) {
        self.cacheConfig = cacheConfig
        self.persistenceConfig = persistenceConfig
        self.timeProvider = timeProvider
    }
    
    // Cache
    
    func getAccountCache() -> IAccountCache {
        lock.wait()
        defer { lock.signal() }
        return accountCache
    }
    
    func getAccessCache() -> IAccessCache {
        lock.wait()
        defer { lock.signal() }
        return accessCache
    }
    
    func getProjectCache() -> IProjectCache {
        lock.wait()
        defer { lock.signal() }
        return projectCache
    }
    
    func getServiceCache() -> IServiceCache {
        lock.wait()
        defer { lock.signal() }
        return serviceCache
    }
    
    func getPropertyCache() -> IPropertyCache {
        lock.wait()
        defer { lock.signal() }
        return propertyCache
    }
    
    // Persistence
    
    func getAccountPersistence(for request: Request) -> IAccountPersistence {
        lock.wait()
        defer { lock.signal() }
        switch persistenceConfig.type {
            // SQL works with a request, so a new instance is required every time
            case .mysql: return AccountPersistenceMySQL(timeProvider: timeProvider, request: request)
            case .inmem: return accountMemPersistence
        }
    }
    
    func getAccessPersistence(for request: Request) -> IAccessPersistence {
        lock.wait()
        defer { lock.signal() }
        switch persistenceConfig.type {
            // SQL works with a request, so a new instance is required every time
            case .mysql: return AccessPersistenceMySQL(timeProvider: timeProvider, request: request)
            case .inmem: return accessMemPersistence
        }
    }
    
    func getProjectPersistence(for request: Request) -> IProjectPersistence {
        lock.wait()
        defer { lock.signal() }
        switch persistenceConfig.type {
            // SQL works with a request, so a new instance is required every time
            case .mysql: return ProjectPersistenceMySQL(timeProvider: timeProvider, request: request)
            case .inmem: return projectMemPersistence
        }
    }
    
    func getServicePersistence(for request: Request) -> IServicePersistence {
        lock.wait()
        defer { lock.signal() }
        switch persistenceConfig.type {
            // SQL works with a request, so a new instance is required every time
            case .mysql: return ServicePersistenceMySQL(timeProvider: timeProvider, request: request)
            case .inmem: return serviceMemPersistence
        }
    }
    
    func getPropertyPersistence(for request: Request) -> IPropertyPersistence {
        lock.wait()
        defer { lock.signal() }
        switch persistenceConfig.type {
            // SQL works with a request, so a new instance is required every time
            case .mysql: return PropertyPersistenceMySQL(timeProvider: timeProvider, request: request)
            case .inmem: return propertyMemPersistence
        }
    }
    
    // Utility
    
    func getTimeProvider() -> TimeProvider {
        return timeProvider
    }
    
}
