import XCTest
@testable import UnifiedConsole

final class UnifiedConsoleTests: XCTestCase {
    func test_stubs() {
        let console = NoLogConsole()
        let logger = NoLogs()
        console.clear(.line)
        logger.logLevel = .debug
        
        XCTAssert(true)
    }

    static var allTests = [
        ("test_stubs", test_stubs),
    ]
}
