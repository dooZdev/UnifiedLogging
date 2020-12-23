import Foundation

#if canImport(ConsoleKit)
import ConsoleKit
#endif
import Logging

public var consoleLoggerLabel: String = "spmpipes.com.logger"

#if os(macOS) || os(Linux) || os(Windows)
public var logger: Logging.LogHandler = {
    LoggingSystem.bootstrap(console: console)
    return ConsoleLogger(label: consoleLoggerLabel, console: console)
}()

/// Logger used sparcely, override this in tests or where not needed
public var console: Console = Terminal()
#else



#endif

