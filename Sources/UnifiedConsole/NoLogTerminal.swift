import Foundation
#if canImport(ConsoleKit)
import ConsoleKit
#endif
import Logging

#if os(macOS) || os(Linux) || os(Windows)
/// Can be used in tests when `@testable import UnifiedConsole` is used to not log anyting
/// Before running tests do ` terminal = NoLogConsole()`
class NoLogConsole: Console {
    
    var size: (width: Int, height: Int) = (width: 0, height: 0)
    var userInfo: [AnyHashable : Any] = [:]
    
    func report(error: String, newLine: Bool) {}
    func input(isSecure: Bool) -> String { "" }
    func output(_ text: ConsoleText, newLine: Bool) {}
    func clear(_ type: ConsoleClear) {}
}
#endif

class NoLogs: Logging.LogHandler {
    subscript(metadataKey _: String) -> Logger.Metadata.Value? {
        get {
            return nil
        }
        set(newValue) {
            
        }
    }
    
    var metadata: Logger.Metadata = [:]
    var logLevel: Logger.Level = .debug
}
