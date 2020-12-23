import XCTest
@testable import UnifiedConsole

final class UnifiedConsoleTests: XCTestCase {
    func test_stubs() {
        #if os(macOS) || os(Linux) || os(Windows)
        let console = NoLogConsole()
        console.clear(.line)
        #endif
        let logger = NoLogs()
        logger.logLevel = .debug
        
        XCTAssert(true)
    }

    static var allTests = [
        ("test_stubs", test_stubs),
    ]
}
