//
//  ListVC.swift
//  RemoteStateTask
//
//  Created by sunil biloniya on 30/03/22.
//

import UIKit

class ListVC: UIViewController {
    @IBOutlet weak var tblList: UITableView!
    var listArray: ListModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        tblList.dataSource = self
        getList()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapMapButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MapVC") as? MapVC
        vc?.data = listArray?.data ?? []
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
}

extension ListVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableCell", for: indexPath) as! ListTableCell
        cell.configData(data: listArray?.data?[indexPath.row])
        return cell
    }
    
}

extension ListVC {
    func getList(){
            let urlpath = "https://api.mystral.in/tt/mobile/logistics/searchTrucks?auth-company=PCH&companyId=33&deactivated=false&key=g2qb5jvucg7j8skpu5q7ria0mu&q-expand=true&q-include=lastRunningState,lastWaypoint".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
            let url = URL(string: urlpath!)
            let task = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) -> Void in
                do {
                    // make sure this JSON is in the format we expect
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                        // try to read out a string array
                        print(json)
                        
                        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
                              let user = try? JSONDecoder().decode(ListModel.self, from: jsonData) else { return }
                        if user.responseCode?.responseCode == 200 {
                            self.listArray = user
    //                        print(self.listArray.)
                            DispatchQueue.main.async {
                                self.tblList.reloadData()
                            }
                        } else {
                            print(user.responseCode?.message ?? "")
                        }
                        
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            }
            task.resume()
        }
    
}
