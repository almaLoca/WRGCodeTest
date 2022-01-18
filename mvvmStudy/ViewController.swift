
import UIKit
import Alamofire
import SwiftyJSON
import CoreData
import SDWebImage

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate  {
    // MARK: - Outlets
    @IBOutlet weak var Search: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var dataModel = RootClass()
    var copyOfDataModel = RootClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        Search.delegate = self
        WebserviceManager.shared.getWS() { (success, response) in
            DispatchQueue.main.async {
                if success{
                    let resData = JSON(response as Any)
                    self.deleteAllData("Test")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        do {
                            // Inserting menu object
                            let test = NSEntityDescription.insertNewObject(forEntityName: "Test", into: context) as! Test
                            test.data = resData.rawString()
                            
                            do {
                                try context.save()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    let loaded = self.loadDataFromLocal()
                                    self.parseDataToModel(data: loaded)
                                }
                                
                            } catch {
                                //  print("Error saving: \(error)")
                            }
                        }
                        
                    }
                    
                }
                else {
                    print("error as any")
                }
            }
        }
        
    }
    // MARK: - searchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //    dataModel = copyOfDataModel
        
        
        dataModel = copyOfDataModel.isEmpty ? [] : copyOfDataModel.filter { $0.name!.contains(searchText) || $0.email!.contains(searchText) }
        if searchText == ""{
            dataModel = copyOfDataModel
        }
        
        tableView.reloadData()
    }
    // MARK: - tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:personTVC = (self.tableView.dequeueReusableCell(withIdentifier: "personTVC") as! personTVC?)!
        
        cell.nameLbl.text = dataModel[indexPath.row].name
        cell.company.text = dataModel[indexPath.row].company?.name
        cell.prfPic.sd_setImage(with: URL(string: dataModel[indexPath.row].profileImage ?? ""))
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dashboard = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        dashboard.datas = dataModel[indexPath.row]
        self.navigationController?.pushViewController(dashboard, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // MARK: - Function  Delete core data files
    func deleteAllData(_ entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else { continue }
                context.delete(objectData)
            }
            
        } catch _ {
            // print("Detele all data in \(entity) error :", error)
        }
    }
    // MARK: - loadDataFromLocal
    func loadDataFromLocal() -> JSON {
        var List = JSON()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Test")
        do {
            let arrFetchResult = try context.fetch(fetchRequest)
            let personData = arrFetchResult.last as! Test
            List = JSON.init(parseJSON: personData.data ?? "")
        }
        catch
        {
            
        }
        return List
    }
    
    // MARK: - parseDataToModel
    func parseDataToModel(data :JSON){
        let decoder = JSONDecoder()
        do{
            let  jsonData = try JSONSerialization.data(withJSONObject: data.object)
            do {
                let response = try decoder.decode(RootClass.self, from:jsonData )
                copyOfDataModel.removeAll()
                dataModel.removeAll()
                dataModel = response
                copyOfDataModel = response
                self.tableView.reloadData()
            } catch {
                print("Parsing Failed")
            }
            
            
        } catch _ {
            print ("UH OOO")
        }
    }
    
}
