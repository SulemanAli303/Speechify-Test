/*
 *****************************************************************************
 *                                                                           *
 *          >>>>>>>>>>>  DO NOT MODIFY THIS FILE  <<<<<<<<<<<                *
 *                                                                           *
 *                YOU WILL AUTOMATICALLY FAIL IF YOU DO!                     *
 *                                                                           *
 *****************************************************************************
 */

import Combine
import Foundation

protocol SessionService: AnyObject {
    func initializeVerificationProcess()
    func verify(completion: @escaping (SessionVerificationResult) -> Void)
}

enum SessionVerificationResult {
    case success
    case error
}

final class DefaultSessionService: SessionService {
    private let sessionSubject = CurrentValueSubject<UUID, Never>(UUID())
    private let verificationSubject = PassthroughSubject<UUID, Error>()

    private var subscription: AnyCancellable?

    func initializeVerificationProcess() {
        verificationSubject.send(sessionSubject.value)
    }

    func verify(completion: @escaping (SessionVerificationResult) -> Void) {
        subscription?.cancel()
        let sessionId = sessionSubject.value
        subscription = verificationSubject
            .verify(sessionId: sessionId, verificationSubject: verificationSubject)
            .sink { [weak subscription] in
                completion($0)
                subscription?.cancel()
            }
    }
}

private extension Publisher where Output == UUID, Failure == Error {
    func verify(
        sessionId: UUID,
        verificationSubject: PassthroughSubject<UUID, Error>
    ) -> AnyPublisher<SessionVerificationResult, Never> {
        self
            .filter { $0 == sessionId }
            .timeout(
                .milliseconds(100),
                scheduler: DispatchQueue.main,
                customError: { NSError(domain: "CustomTimeoutError", code: -1) }
            )
            .map { _ in SessionVerificationResult.success }
            .handleEvents(receiveOutput: { result in
                if case .error = result {
                    verificationSubject.send(completion: .finished)
                }
            })
            .catch { error in
                Just(SessionVerificationResult.success)
            }
            .eraseToAnyPublisher()
    }
}

/*
 *****************************************************************************
 *                   END OF FILE - DO NOT MODIFY ANYTHING!                   *
 *****************************************************************************
 */
