import UIKit

class CharacterViewController<View: CharacterView>: BaseViewController<View> {

    private var characters: [Character] = []

    private let dataProvider: CharacterDataProvider
    private let imageService: ImageService
    private let charactersUrlsList: [String]
    private let updateQueue = DispatchQueue(label: "CharacterRequestQue")

    init(dataProvider: CharacterDataProvider, viewModel: LocationCellData, imageService: ImageService) {
        self.dataProvider = dataProvider
        self.imageService = imageService
        charactersUrlsList = viewModel.residents
        super.init(nibName: nil, bundle: nil)

        title = "Жители локации \(viewModel.name)"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        charactersUrlsList.forEach { url in
            requestCharacter(url: url) { [weak self] character in
                self?.imageService.getImage(url: character.image) { [weak self]image in
                    print(image?.size ?? 0)
                }
            }
        }
    }

    private func requestCharacter(url: String, completion: @escaping (Character) -> Void) {
        if let character = characters.first(where: { $0.url == url }) {
            completion(character)
            return
        }
        DispatchQueue.global().async {
            self.dataProvider.singleCharacter(url: url) { [weak self] result in
                switch result {
                case let .success(character):
                    self?.updateQueue.async {
                        self?.characters.append(character)
                        completion(character)
                    }
                case .failure:
                    print("character load fail")
                }
            }
        }
    }
}
