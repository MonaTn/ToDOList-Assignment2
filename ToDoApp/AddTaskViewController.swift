//
//  AddTaskViewController.swift
//  ToDoApp
//
//  Created by Mona Torabian on 2017-04-06.
//  Copyright © 2017 Mon Tn. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var isImportant: UISwitch!
    
    @IBOutlet weak var taskNotesField: UITextView!

    @IBOutlet weak var btn: UIButton!
    
    var editMode : Bool = false
   
    var index : Int = 0
    
    override func viewDidLoad() {
       super.viewDidLoad()
    }
        
      // add & update a task
    @IBAction func btnAdd(_ sender: UIButton) {
        
        let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Update a task
        if (editMode) {

            let fetchRequest : NSFetchRequest<Task> = Task.fetchRequest()
            do {
                let fetchResults = try contex.fetch(fetchRequest)
                let task = fetchResults[index]
                task.name = textField.text!
                task.notes = taskNotesField.text
                task.isImportant = isImportant.isOn
                
                }catch {
                    print(" \(error)")

            }
            editMode = false

        // Add a new task
        } else {
            let task = Task(context: contex)
            task.name = textField.text!
            task.notes = taskNotesField.text
            task.isCompleted = false
            task.isImportant = isImportant.isOn

        }
        
        // Save the data to coreData
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // Back to the task list view 
        if (sender.titleLabel?.text == "UPDATE") {
            dismiss(animated: true, completion: nil)
            
        } else {
            navigationController!.popViewController(animated: true)
        }
    }

 }
