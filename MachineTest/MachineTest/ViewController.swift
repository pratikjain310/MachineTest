//
//  ViewController.swift
//  MachineTest
//
//  Created by SNEAHAAL on 11/05/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var arrayListTableView: UITableView!
    @IBOutlet weak var deletedArrayListTableView: UITableView!
    // Names of Employees
    var arrayList : [String] = ["Pratik", "Ranjit", "Jash", "Rahul", "Yash"]
    var deletedArrayList : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func viewDidAppear(_ animated: Bool) {
        // Showing Alert Action so the user gets to know he have to swipe right to delete or redo Data
        let alert = UIAlertController.init(title: "Hint", message: "Swipe Right to Delete/Redo Data", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

}


extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Returning count of Rows According to TableView and Checking because we have 2 Tableview on a single screen
        if tableView == arrayListTableView {
            return arrayList.count
        }else {
            return deletedArrayList.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //created DummyCell because while checking condition in if both condition are fales it will return nothing and we will get error
        let dummyCell = UITableViewCell()
        if tableView == arrayListTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")as! ArrayListTableViewCell
            cell.arrayItemLabel.text = arrayList[indexPath.row]
            return cell
        }else if tableView == deletedArrayListTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2")as! DeletedArrayListTableViewCell
            cell.deletedItemLabel.text = deletedArrayList[indexPath.row]
            return cell
        }
        return dummyCell
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == arrayListTableView {
            let action = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] (action, view, nil) in
                self.deletedArrayList.append( arrayList[indexPath.row])
                self.arrayList.remove(at: indexPath.row)
                arrayListTableView.reloadData()
                deletedArrayListTableView.reloadData()
            }
            return UISwipeActionsConfiguration(actions: [action])
        }else {
            let action = UIContextualAction(style: .normal, title: "Redo") { [unowned self] (action, view, nil) in
                self.arrayList.append(deletedArrayList[indexPath.row])
                self.deletedArrayList.remove(at: indexPath.row)
                arrayListTableView.reloadData()
                deletedArrayListTableView.reloadData()
            }
            return UISwipeActionsConfiguration(actions: [action])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46.0
    }
}



