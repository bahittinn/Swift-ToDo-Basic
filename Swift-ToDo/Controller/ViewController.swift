//
//  ViewController.swift
//  Swift-ToDo
//
//  Created by Bahittin on 12.07.2023.
//

import UIKit

class ViewController: UITableViewController {
    
    var itemArray = [todoModel]()
    
    @IBOutlet var todoTableView: UITableView!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        //navigationController?.navigationBar.prefersLargeTitles = true
        super.viewDidLoad()
        todoTableView.delegate = self
        todoTableView.dataSource = self
        if let items = UserDefaults.standard.stringArray(forKey: "items") as? [String] {
            let newItem = todoModel()
            itemArray.append(newItem)
        }
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Ekleme Yap", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ekle", style: .default) { (action) in
            print(textField.text!)
            let newItem = todoModel()
            newItem.jobName = textField.text!
            newItem.iscompleted = false
            
            DispatchQueue.main.async {
                var currentItems = UserDefaults.standard.array(forKey: "items")
                currentItems?.append([textField.text])
                
                self.itemArray.append(newItem)
                UserDefaults.standard.setValue([currentItems], forKey: "items")
                self.tableView.reloadData()
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Yapılacaklarınızı yazın"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
    }
}
extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoViewCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.jobName
       
        cell.accessoryType = item.iscompleted ? .checkmark : .none
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].iscompleted = !itemArray[indexPath.row].iscompleted
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

