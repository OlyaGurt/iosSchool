import Foundation

protocol CharacterAssembly {
    func characterCoordinator(viewModel: LocationCellData) -> CharacterCoordinator
    func characterVC(viewModel: LocationCellData) -> CharacterViewController<CharacterViewImp>
    func characterDataProvider() -> CharacterDataProvider
}

extension Assembly: CharacterAssembly {
    func characterCoordinator(viewModel: LocationCellData) -> CharacterCoordinator {
        CharacterCoordinator(assembly: self, context: .init(viewModel: viewModel))
    }

    func characterVC(viewModel: LocationCellData) -> CharacterViewController<CharacterViewImp> {
        .init(dataProvider: characterDataProvider(), viewModel: viewModel, imageService: imageService)
    }

    func characterDataProvider() -> CharacterDataProvider {
        CharacterDataProviderImp(apiClient: apiClient)
    }
}
