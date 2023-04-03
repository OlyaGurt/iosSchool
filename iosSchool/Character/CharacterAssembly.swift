import Foundation

protocol CharacterAssembly {
    func characterCoordinator() -> CharacterCoordinator
    func characterVC() -> CharacterViewController<CharacterViewImp>
    func characterDataProvider() -> CharacterDataProvider
}

extension Assembly: CharacterAssembly {
    func characterCoordinator() -> CharacterCoordinator {
        CharacterCoordinator(assembly: self, context: .init())
    }

    func characterVC() -> CharacterViewController<CharacterViewImp> {
        .init(dataProvider: characterDataProvider())
    }

    func characterDataProvider() -> CharacterDataProvider {
        CharacterDataProviderImp(apiClient: apiClient)
    }
}
