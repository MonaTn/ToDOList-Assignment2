//
//  ViewController.swift
//  ToDoApp
//
//  Created by Mona Torabian on 2017-04-06.
//  Copyright © 2017 Mon Tn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

   
    var tasks : [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Get tha data from coreData
        getData()
        
        // Reload tha data
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let task = tasks[indexPath.row]
        
        //if the task is important
        if task.isImportant {
            cell.textLabel?.text = "❗️\(task.name!)"
        } else {
            cell.textLabel?.text = task.name!
        }
        // if the task is completed
        
        if task.isCompleted {
            cell.textLabel?.textColor = UIColor.gray
            cell.textLabel?.font = UIFont.italicSystemFont(ofSize: 20)
        }
        
        return cell
        
    }
    
    // get data from CoreData 
    func getData() {
        let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
        tasks = try contex.fetch(Task.fetchRequest())
        } catch
            {
            print("Fetching Feiled")
            }
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // action title can be Done or Redo
        var actionTitle : String
        
        let task = self.tasks[indexPath.row]
        
        if task.isCompleted {
            actionTitle = "Redo"
        } else {
            actionTitle = "Done"
        }
        // if a task is done
        let doneAction = UITableViewRowAction(style: .default, title: actionTitle) { (action, indexPath) in
            if actionTitle == "Done" {
                task.isCompleted = true
            }else {
                task.isCompleted = false
            }
            tableView.reloadData()
        }
        
        if actionTitle == "Done" {
            doneAction.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        } else {
            doneAction.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        }
        
        // delete a task from the todo list
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
           
            let task = self.tasks[indexPath.row]
            contex.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
                self.tasks = try contex.fetch(Task.fetchRequest())
            } catch
                    {
                print("Fetching Feiled")
                
                }
            tableView.reloadData()

        }
        
        // edit a task 
        let editAction = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            
            //instantiate the view controller with storyboard ID
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TaskDetailViewController") as! AddTaskViewController
            self.present(vc, animated: true, completion: {
                
                let task = self.tasks[indexPath.row]
                vc.textField.text = task.name
                vc.taskNotesField.text = task.notes
                vc.isImportant.setOn(task.isImportant, animated: true)
                vc.navigationItem.title = "Edit a Task"
                vc.btn.titleLabel?.text = "UPDATE"
                vc.editMode = true
                vc.index = indexPath.row
                
            })
            tableView.reloadData()

        }

        editAction.backgroundColor = #colorLiteral(red: 0.1927247376, green: 0.3953451907, blue: 1, alpha: 1)
        return [doneAction,deleteAction, editAction]
    }
    
 }
 
    
    
    
    
    
    
    
    
    
    
    
    
    
    



