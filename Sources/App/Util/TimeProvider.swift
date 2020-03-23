import Foundation

protocol TimeProvider {
    func epochMillis() -> Int64
}
