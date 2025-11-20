/*
 *****************************************************************************
 *                                                                           *
 *          >>>>>>>>>>>  DO NOT MODIFY THIS FILE  <<<<<<<<<<<                *
 *                                                                           *
 *                YOU WILL AUTOMATICALLY FAIL IF YOU DO!                     *
 *                                                                           *
 *****************************************************************************
 */

protocol AnalyticsService {
    func fetchAnalyticsDetails() async -> [AnalyticsDetails]
}

class MockAnalyticsService: AnalyticsService {
    func fetchAnalyticsDetails() async -> [AnalyticsDetails] {
        let delay = UInt64.random(in: 100_000_000...1_000_000_000)
        try? await Task.sleep(nanoseconds: delay)
        return [
            AnalyticsDetails(id: 0, title: "Sprint Velocity", value: 42, trend: "↑ 15%", period: "Last 30 days"),
            AnalyticsDetails(id: 1, title: "Bug Resolution Time", value: 24, trend: "↓ 30%", period: "Last 7 days"),
            AnalyticsDetails(id: 2, title: "Code Coverage", value: 85, trend: "↑ 5%", period: "Current Sprint")
        ]
    }
}

/*
 *****************************************************************************
 *                   END OF FILE - DO NOT MODIFY ANYTHING!                   *
 *****************************************************************************
 */
