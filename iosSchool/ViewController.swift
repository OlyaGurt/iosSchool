import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let newGen = ColorGenerator(alpha: 1)
        newGen.alpha = 0.5
        let color = Color(red: 1, green: 1, blue: 1, alpha: .bright)
        color.description()
        // Do any additional setup after loading the view.
    }
}
