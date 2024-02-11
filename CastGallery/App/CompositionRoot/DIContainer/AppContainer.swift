//
//  AppContainer.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

protocol AppContainer {
    var apiClient: ApiClientService & RemoteImageDataService { get }
    var localDataService: LocalDataImageService { get }

    func getDataImageUseCase() -> ImageDataUseCase
}

struct AppContainerImplementation: AppContainer {
    var apiClient: ApiClientService & RemoteImageDataService = ApiClientServiceImplementation()
    var localDataService: LocalDataImageService = LocalDataImageServiceImplementation()

    func getDataImageUseCase() -> ImageDataUseCase {
        let imageDataRepository = ImageDataRepositoryImplementation(remoteDataServiece: apiClient, localDataCache: localDataService)
        return ImageDataUseCaseImplementation(imageDataRepository: imageDataRepository)
    }
}
