/*
 *****************************************************************************
 *                                                                           *
 *          >>>>>>>>>>>  DO NOT MODIFY THIS FILE  <<<<<<<<<<<                *
 *                                                                           *
 *                YOU WILL AUTOMATICALLY FAIL IF YOU DO!                     *
 *                                                                           *
 *****************************************************************************
 */

/**
 # Task #2

 ## Task
 Fix the concurrency implementation in `DefaultReminderService` to correctly handle parallel reminder fetching using three different paradigms:

 1. Callback-Based (`fetchReminders`)
 2. Combine (`remindersPublisher`)
 3. Swift Concurrency (`fetchRemindersAsync`)

 Each implementation must:
 - Fetch three pages of reminders in parallel
 - Return a total of 12 reminders
 - Pass all associated tests in `DefaultReminderServiceTests`

 ## Success Criteria
 - All tests in `DefaultReminderServiceTests` pass successfully
 - Each method fetches exactly three pages concurrently
 - All methods return 12 unique reminders
 - Each implementation uses its designated concurrency paradigm
 - Each method has a unique implementation

 ## Important Notes
 - Some files are marked as "DO NOT MODIFY" - these must remain unchanged
 - In certain files, only specific sections are marked as protected with clear comments
 - Modifying any protected code (either entire files or marked sections) will result in automatic task failure
 - Work with the existing code structure; do not rewrite from scratch
 - Stay within each method's designated paradigm (Callbacks/Combine/Swift Concurrency)
 - Do not call other methods of the class within implementations
 */

@testable import DebuggingChallenge
import Combine
import XCTest

final class DefaultReminderServiceTests: XCTestCase {

    var sut: DefaultReminderService!

    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        sut = DefaultReminderService(dataSource: ReminderDataSourceStub())
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        sut = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testFetchReminders() {
        let expectation = expectation(description: "Should fetch 12 reminders")

        sut.fetchReminders { reminders in
            XCTAssertEqual(reminders.count, 12, "Expected 12 reminders to be returned")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testRemindersPublisher() {
        let expectation = expectation(description: "Should fetch all reminders")

        sut.remindersPublisher()
            .sink { reminders in
                XCTAssertEqual(reminders.count, 12)

                let uniqueIds = Set(reminders.map { $0.id })
                XCTAssertEqual(uniqueIds.count, 12)

                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
    }

    func testFetchRemindersAsync() async {
            let startTime = Date()

            let reminders = await sut.fetchRemindersAsync()

            let elapsedTime = Date().timeIntervalSince(startTime)
            XCTAssertEqual(reminders.count, 12, "Should fetch 12 reminders")
            XCTAssertLessThan(elapsedTime, 0.5)
        }
}
/*
 *****************************************************************************
 *                   END OF FILE - DO NOT MODIFY ANYTHING!                   *
 *****************************************************************************
 */
