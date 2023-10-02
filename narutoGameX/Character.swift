import UIKit

struct Character: Codable {
    var name: String
    var imageData: Data

    init(name: String, image: UIImage) {
        self.name = name
        self.imageData = image.pngData() ?? Data()
    }

    func getImage() -> UIImage? {
        return UIImage(data: imageData)
    }
}
