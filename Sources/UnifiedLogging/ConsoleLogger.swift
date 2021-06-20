import Foundation
import Logging

public var consoleLoggerLabel: String = "spmpipes.com.logger"

public struct Log: Console {
    public func output(_ text: @autoclosure () -> String) {
        print(text())
    }
}
public var console: Console = Log()

public var logger: Logger = {
    LoggingSystem.bootstrap(console: console)
    return Logging.Logger(label: "UnifiedLogging.default")
}()

public protocol Console {
    func output(_ text: @autoclosure () -> String)
}

/// Outputs logs to a `Console`.
public struct ConsoleLogger: LogHandler {
    public let label: String
    
    /// See `LogHandler.metadata`.
    public var metadata: Logger.Metadata
    
    /// See `LogHandler.logLevel`.
    public var logLevel: Logger.Level
    
    /// The conosle that the messages will get logged to.
    public let console: Console
    
    /// Creates a new `ConsoleLogger` instance.
    ///
    /// - Parameters:
    ///   - label: Unique identifier for this logger.
    ///   - console: The console to log the messages to.
    ///   - level: The minimum level of message that the logger will output. This defaults to `.debug`, the lowest level.
    ///   - metadata: Extra metadata to log with the message. This defaults to an empty dictionary.
    public init(label: String, console: Console, level: Logger.Level = .debug, metadata: Logger.Metadata = [:]) {
        self.label = label
        self.metadata = metadata
        self.logLevel = level
        self.console = console
    }
    
    /// See `LogHandler[metadataKey:]`.
    ///
    /// This just acts as a getter/setter for the `.metadata` property.
    public subscript(metadataKey key: String) -> Logger.Metadata.Value? {
        get { return self.metadata[key] }
        set { self.metadata[key] = newValue }
    }
    
    public func log(
        level: Logger.Level,
        message: Logger.Message,
        metadata: Logger.Metadata?,
        source: String,
        file: String,
        function: String,
        line: UInt)
    {
        
        var text: String = ""
        
        if self.logLevel <= .trace {
            text += "[ \(self.label) ] "
        }
        
        text += "[ \(level.name) ]"
            + " "
            + message.description
        
        let allMetadata = (metadata ?? [:]).merging(self.metadata) { (a, _) in a }
        
        if !allMetadata.isEmpty {
            // only log metadata if not empty
            text += " " + allMetadata.sortedDescriptionWithoutQuotes
        }
        
        // log file info if we are debug or lower
        if self.logLevel <= .debug {
            // log the concise path + line
            let fileInfo = self.conciseSourcePath(file) + ":" + line.description
            text += " (" + fileInfo + ")"
        }
        
        self.console.output(text)
    }
    
    /// splits a path on the /Sources/ folder, returning everything after
    ///
    ///     "/Users/developer/dev/MyApp/Sources/Run/main.swift"
    ///     // becomes
    ///     "Run/main.swift"
    ///
    private func conciseSourcePath(_ path: String) -> String {
        let separator: Substring = path.contains("Sources") ? "Sources" : "Tests"
        return path.split(separator: "/")
            .split(separator: separator)
            .last?
            .joined(separator: "/") ?? path
    }
}

private extension Logger.Metadata {
    var sortedDescriptionWithoutQuotes: String {
        let contents = Array(self)
            .sorted(by: { $0.0 < $1.0 })
            .map { "\($0.description): \($1)" }
            .joined(separator: ", ")
        return "[\(contents)]"
    }
}

extension LoggingSystem {
    /// Bootstraps a `ConsoleLogger` to the `LoggingSystem`, so that logger will be used in `Logger.init(label:)`.
    ///
    ///     LoggingSystem.boostrap(console: console)
    ///
    /// - Parameters:
    ///   - console: The console the logger will log the messages to.
    ///   - level: The minimum level of message that the logger will output. This defaults to `.debug`, the lowest level.
    ///   - metadata: Extra metadata to log with the message. This defaults to an empty dictionary.
    public static func bootstrap(console: Console, level: Logger.Level = .info, metadata: Logger.Metadata = [:]) {
        self.bootstrap { label in
            return ConsoleLogger(label: label, console: console, level: level, metadata: metadata)
        }
    }
}

extension Logger.Level {
    
    public var name: String {
        switch self {
            case .trace: return "TRACE"
            case .debug: return "DEBUG"
            case .info: return "INFO"
            case .notice: return "NOTICE"
            case .warning: return "WARNING"
            case .error: return "ERROR"
            case .critical: return "CRITICAL"
        }
    }
}

/// Useable in tests via `@testable import UnifiedLogging`
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
    
    func log(level: Logger.Level, message: Logger.Message, metadata: Logger.Metadata?, source: String, file: String, function: String, line: UInt) {
        
    }
    func log(level: Logger.Level, message: Logger.Message, metadata: Logger.Metadata?, file: String, function: String, line: UInt) {
        
    }
}
