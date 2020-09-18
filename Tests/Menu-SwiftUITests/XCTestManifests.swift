import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Menu_SwiftUITests.allTests),
    ]
}
#endif
