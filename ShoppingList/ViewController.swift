//
//  ViewController.swift
//  ShoppingList
//
//  Created by rushabh on 21/02/17.
//  Copyright © 2017 CentennialCollege. All rights reserved.
//  Alisha Zaveri - 300912073

import UIKit
import CoreData

class tableViewController: UITableViewController {

    var ListItems = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // Add button to add items
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(tableViewController.addItem))
    }

    
    // Add Function to add new items
    func addItem(){
        
        let alertController = UIAlertController(title: "Enter Here", message: "List", preferredStyle: UIAlertControllerStyle.alert)
        
        
        //save button
        let confirmAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: ({
            (_) in
            
           if let field = alertController.textFields![0] as? UITextField{
            
            self.saveItem(itemToSave: field.text!)
            self.tableView.reloadData()
            }
        }
        ))
        
        
        //cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addTextField(configurationHandler: {
            (textField) in
            
            textField.placeholder = "Enter Items"
        })
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    
    }
    
    
    //Save item function
    func saveItem(itemToSave : String){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "ShoppingList", in: managedContext)
        
        let item = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        item.setValue(itemToSave, forKey: "item")
        
        do{
            try managedContext.save()
            ListItems.append(item)
        }
        catch{
          
            print("error")
        }
         //To display the list in tableview
          func viewWillAppear(animated :Bool){
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ShoppingList")
            
            do{
                let results = try managedContext.execute(fetchRequest)
                
                ListItems = results as! [NSManagedObject]
            }
            catch{
                print("error")
            }
            
        }
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ListItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell
    
        let item = ListItems[indexPath.row]
        
        cell.textLabel?.text = item.value(forKey: "item") as? String
        
        return cell
    }
    
    //@IBOutlet weak var ListName: UITextField!
    
   // @IBOutlet weak var ListLabel: UILabel!
    
    //@IBOutlet weak var ItemList: UITextField!
    
    @IBAction func Quantity(_ sender: UIStepper) {
        
    }
    
    
}

