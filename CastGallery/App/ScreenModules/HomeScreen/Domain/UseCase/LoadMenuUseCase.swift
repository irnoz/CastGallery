//
//  LoadMenuUseCase.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 10.02.24.
//

protocol LoadMenuUseCase {
    func execute() async -> Result<[MenuItem], Error>
}

struct LoadMenuUseCaseImplementation: LoadMenuUseCase {

    let menuRepository: MenuRepository

    func execute() async -> Result<[MenuItem], Error> {
        do {
            let repositoryResult = try await menuRepository.fetchMenuData()
            return .success(repositoryResult)
        } catch {
            return .failure(error)
        }
    }
}
