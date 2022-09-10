

import Foundation
import UIKit

extension HomeVC:UITableViewDelegate,UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  print(dataForTableView.count)
        return dataForTableView.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
            do {
                let s = "\(self.baseImageUrl)\((dataForTableView[indexPath.row].backdropPath) ?? "/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg")"
            let data = try Data(contentsOf: URL(string:s)!)
                cell.backdropPath.image = UIImage(data: data)
            }catch{
                print(error)
            }
            cell.title.text = dataForTableView[indexPath.row].title
        return cell
    }
    
}
