//
//  AddTaskViewController.swift
//  ToDoApp
//
//  Created by Mona Torabian on 2017-04-06.
//  Copyright © 2017 Mon Tn. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var isImportant: UISwitch!
    
    @IBOutlet weak var taskNotesField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAdd(_ sender: UIButton) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let task = Task(context: context)
        task.name = textField.text!
        task.notes = taskNotesField.text
        task.isCompleted = false
        task.isImportant = isImportant.isOn
        
        // Save the data to coreData
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }

}
