

import Foundation
import UIKit

extension HomeVC:UITableViewDelegate,UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForTableView.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
                let url = "\(self.baseImageUrl)\((self.dataForTableView[indexPath.row].backdropPath) ?? "/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg")"
                cell.backdropPath.imageFromServerURL(url, placeHolder:nil)
                cell.title.text = self.dataForTableView[indexPath.row].title
            
        return cell
    
       }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension UIImageView {
        func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        self.image = nil
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
