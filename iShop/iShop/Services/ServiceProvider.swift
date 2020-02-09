import Foundation
import UIKit

let defaultSession = URLSession(configuration: .default)
var dataTask: URLSessionDataTask?
class Service {
    
@IBOutlet weak var imageView: UIImageView!
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
}
