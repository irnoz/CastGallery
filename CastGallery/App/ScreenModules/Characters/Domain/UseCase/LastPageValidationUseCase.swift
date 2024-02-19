//
//  LastPageValidationUseCase.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

protocol LastPageValidationUseCase {
    var lastPage: Bool { get }
    mutating func updateLastPage(itemsCount: Int)
    func checkAndLoadMoreItems(row: Int, actualItems: Int, action: () -> Void)
}

struct LastPageValidationUseCaseImplementation: LastPageValidationUseCase {

    // MARK: - Public Properties
    var lastPage: Bool = false

    // MARK: - Private Properties
    private var threshold = Constants.threshold

    // MARK: - Helper Methods
    mutating func updateLastPage(itemsCount: Int) {
        if itemsCount == Int.zero {
            lastPage = true
        }
    }

    func checkAndLoadMoreItems(row: Int, actualItems: Int, action: () -> Void) {
        guard !lastPage else { return }
        let limit = actualItems - threshold
        if limit == row {
            action()
        }
    }
}
