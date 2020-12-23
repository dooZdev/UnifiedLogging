import Foundation
import Logging

public var consoleLoggerLabel: String = "spmpipes.com.logger"

#if os(macOS) || os(Linux) || os(Windows)
import ConsoleKit
public var logger: Logging.LogHandler = {
    LoggingSystem.bootstrap(console: console)
    return ConsoleLogger(label: consoleLoggerLabel, console: console)
}()

/// Logger used sparcely, override this in tests or where not needed
public var console: Console = Terminal()
#else
import UnifiedLogging

struct Log: Console {
    func output(_ text: @autoclosure () -> String) {
        print(text())
    }
}
public var console: Console = Log()

public var logger: Logging.LogHandler = {
    LoggingSystem.bootstrap(console: console)
    return ConsoleLogger(label: consoleLoggerLabel, console: console)
}()


#endif

