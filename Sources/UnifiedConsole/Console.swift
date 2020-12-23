import Foundation
import ConsoleKit
import Logging

public var consoleLoggerLabel: String = "spmpipes.com.logger"
/// Logger used sparcely, override this in tests or where not needed
public var console: Console = Terminal()
public var logger: Logging.LogHandler = {
    LoggingSystem.bootstrap(console: console)
    return ConsoleLogger(label: consoleLoggerLabel, console: console)
}()
    
