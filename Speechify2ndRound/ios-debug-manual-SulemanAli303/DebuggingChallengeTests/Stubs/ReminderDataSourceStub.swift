/*
 *****************************************************************************
 *                                                                           *
 *          >>>>>>>>>>>  DO NOT MODIFY THIS FILE  <<<<<<<<<<<                *
 *                                                                           *
 *                YOU WILL AUTOMATICALLY FAIL IF YOU DO!                     *
 *                                                                           *
 *****************************************************************************
 */

@testable import DebuggingChallenge
import Foundation

class ReminderDataSourceStub: ReminderDataSource {    
    func fetchReminders(completion: @escaping ([DebuggingChallenge.Reminder]) -> Void) {
        fetchReminders(randomDelay: true, completion: completion)
    }

    func fetchReminders() async -> [Reminder] {
        await withCheckedContinuation { continuation in
            fetchReminders(randomDelay: false) { reminders in
                continuation.resume(returning: reminders)
            }
        }
    }

    private func fetchReminders(randomDelay: Bool, completion: @escaping ([DebuggingChallenge.Reminder]) -> Void) {
        let reminders = [
            Reminder(id: UUID(), message: "Submit project proposal"),
            Reminder(id: UUID(), message: "Review design specifications"),
            Reminder(id: UUID(), message: "Schedule stakeholder meeting"),
            Reminder(id: UUID(), message: "Finalize budget review")
        ]
        DispatchQueue.main.asyncAfter(deadline: .now() + (randomDelay ? Double.random(in: 0.1...0.5) : 0.3)) {
            completion(reminders)
        }
    }
}
/*
 *****************************************************************************
 *                    END OF FILE - DO NOT MODIFY ANYTHING!                  *
 *****************************************************************************
 */
