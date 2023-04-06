import UIKit

class CharacterViewController<View: CharacterView>: BaseViewController<View> {

    private let dataProvider: CharacterDataProvider

    init(dataProvider: CharacterDataProvider) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataProvider.character(characterId: "821") { [weak self] result in
            switch result {
            case .success(let response):
                print("success")
                print(response)
            case .failure(let failure):
                print(failure.rawValue)
                print("fail")
            }
        }
    }
}
