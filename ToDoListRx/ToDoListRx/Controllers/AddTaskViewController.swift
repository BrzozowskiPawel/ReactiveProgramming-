//
//  AddTaskViewController.swift
//  ToDoListRx
//
//  Created by Paweł Brzozowski on 24/01/2022.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var prioritySegmentedControll: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        // Check if there is data to create task
        guard let priority = Priority(rawValue: self.prioritySegmentedControll.selectedSegmentIndex), let title = self.taskTitleTextField.text else {
            return
        }
        
        // Create a task
        let task = Task(title: title, priority: priority)
    }
    
}
