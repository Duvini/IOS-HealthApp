import HealthKit

class HealthKitManager {
    static let shared = HealthKitManager()
    private let healthStore = HKHealthStore()

    // Types to read
    private let readDataTypes: Set<HKObjectType> = [
        HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKObjectType.quantityType(forIdentifier: .stepCount)!
    ]

    // Check if HealthKit is available
    func isHealthKitAvailable() -> Bool {
        return HKHealthStore.isHealthDataAvailable()
    }

    // Request Authorization
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        guard isHealthKitAvailable() else {
            completion(false, nil)
            return
        }

        healthStore.requestAuthorization(toShare: nil, read: readDataTypes) { success, error in
            completion(success, error)
        }
    }

    // Fetch Step Count
    func fetchStepCount(completion: @escaping (Double?, Error?) -> Void) {
        guard let stepType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            completion(nil, nil)
            return
        }

        let startOfDay = Calendar.current.startOfDay(for: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: Date(), options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(nil, error)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()), nil)
        }

        healthStore.execute(query)
    }
}
