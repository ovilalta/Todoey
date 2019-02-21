//
//  ViewController.swift
//  Todoey
//
//  Created by Oscar Vilalta on 12/27/18.
//  Copyright © 2018 Oscar Vilalta. All rights reserved.
//

import UIKit

class TodoListViewController : UITableViewController {
    
    var itemArray = [Item]()
    
    //Constante para guardar la información del arreglo de datos usado
    //let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
                
        loadItems()
        
    }

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item  = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        //Ternary operator para sustituir el if
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Agregar más elementos a la lista
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Agregar nuevo elemento a la lista", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Agregar elemento", style: .default) { (action) in
           
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Crear un nuevo elemento"
            print(alertTextField)
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems() {
        //Guarda la información en archivo interno para recuperar la información
        //self.defaults.set(self.itemArray, forKey: "TodoListArray")
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array,\(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error al decodificar, \(error)")
            }
        }
    }
}

