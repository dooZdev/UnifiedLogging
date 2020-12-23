import Foundation
import Logging


#if os(macOS) || os(Linux) || os(Windows)
import ConsoleKit
public var consoleLoggerLabel: String = "spmpipes.com.logger"
public var logger: Logging.LogHandler = {
    LoggingSystem.bootstrap(console: console)
    return ConsoleLogger(label: consoleLoggerLabel, console: console)
}()

/// Logger used sparcely, override this in tests or where not needed
public var console: Console = Terminal()
#else
import UnifiedLogging

#endif

