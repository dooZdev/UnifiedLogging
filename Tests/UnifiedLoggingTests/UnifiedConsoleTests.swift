import XCTest
@testable import UnifiedLogging

final class UnifiedLoggingTests: XCTestCase {
    func test_stubs() {
        let logger = NoLogs()
        logger.logLevel = .debug
        
        XCTAssert(true)
    }

    static var allTests = [
        ("test_stubs", test_stubs),
    ]
}
