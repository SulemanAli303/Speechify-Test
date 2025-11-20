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

import Combine
import Foundation

final class DefaultReminderService: ReminderService {
    private let dataSource: ReminderDataSource

    init(dataSource: ReminderDataSource) {
        self.dataSource = dataSource
    }

    func fetchReminders(completion: @escaping ([Reminder]) -> Void) {
        let group = DispatchGroup()
        var reminders: [Reminder] = []
        for _ in 0 ..< 3 {
            group.enter()
            dataSource.fetchReminders {
                reminders.append(contentsOf: $0)
                group.leave()
            }
        }
        group.notify(queue: .main, execute: {
            completion(reminders)
        })
    }

    func remindersPublisher() -> AnyPublisher<[Reminder], Never> {
        let remainderPublisher = (0..<3).map { _ in
            Future<[Reminder], Never> { promise in
                self.dataSource.fetchReminders {
                    promise(.success($0))
                }
            }
        }

        return Publishers.MergeMany(remainderPublisher)
            .collect()
            .map { $0.flatMap { $0 } }
            .eraseToAnyPublisher()
    }

    func fetchRemindersAsync() async -> [Reminder] {
        return await withTaskGroup(of: [Reminder].self, body: { remainderGroup in
            for _ in 0..<3 {
                remainderGroup.addTask(operation: {
                    return await self.dataSource.fetchReminders()
                })
            }
            var reminders: [Reminder] = []
            for await remainder in remainderGroup {
                reminders.append(contentsOf: remainder)
            }
            return reminders
        })
    }
}
/*
 *****************************************************************************
 *                                                                           *
 *     >>>>>>>>>>>  DO NOT MODIFY ANYTHING FROM THIS POINT  <<<<<<<<<<<      *
 *                                                                           *
 *                YOU WILL AUTOMATICALLY FAIL IF YOU DO!                     *
 *                                                                           *
 *****************************************************************************
 */

protocol ReminderService: AnyObject {
    func fetchReminders(completion: @escaping ([Reminder]) -> Void)
    func remindersPublisher() -> AnyPublisher<[Reminder], Never>
    func fetchRemindersAsync() async -> [Reminder]
}

protocol ReminderDataSource: AnyObject {
    func fetchReminders(completion: @escaping ([Reminder]) -> Void)
    func fetchReminders() async -> [Reminder]
}
