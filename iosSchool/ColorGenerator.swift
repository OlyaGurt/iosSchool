import Foundation

enum Brightnes: Double {
    case dim = 0.1
    case average = 0.5
    case bright = 1
    func description() -> String {
        switch self {
        case .dim:
            return "dim"
        case .average:
            return "average"
        case .bright:
            return "bright"
        }
    }
}

struct Color {
    let red: Double
    let green: Double
    let blue: Double
    var alpha: Brightnes
    func description() {
//    print("R: \(red), G: \(green), B: \(blue), alpha: \(alpha.rawValue)")
    }
}

class ColorGenerator {
    let colorCodes: [Double] = [0.0, 51.0, 102.0, 153.0, 204, 0, 255.0]
    var alpha: Double
    init(alpha: Double) {
        self.alpha = alpha
    }
    init?(alpha: Double?) {
        guard let alpha, alpha > 0 && alpha < 1 else {
            return nil
        }
        self.alpha = alpha
    }
}
