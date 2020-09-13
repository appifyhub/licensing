import Foundation

// Inspired by & based on https://gist.github.com/nestserau/ce8f5e5d3f68781732374f7b1c352a5a

public final class AtomicInteger {
    
    private let lock = DispatchSemaphore(value: 1)
    private var _value: Int
    
    public init(value initialValue: Int = 0) {
        _value = initialValue
    }
    
    public var value: Int {
        
        get {
            lock.wait()
            defer { lock.signal() }
            return _value
        }
        
        set {
            lock.wait()
            defer { lock.signal() }
            _value = newValue
        }
        
    }
    
    public func decrementAndGet() -> Int {
        lock.wait()
        defer { lock.signal() }
        _value -= 1
        return _value
    }
    
    public func incrementAndGet() -> Int {
        lock.wait()
        defer { lock.signal() }
        _value += 1
        return _value
    }
    
}
