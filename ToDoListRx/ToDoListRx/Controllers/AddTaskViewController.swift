//
//  AddTaskViewController.swift
//  ToDoListRx
//
//  Created by Paweł Brzozowski on 24/01/2022.
//

import UIKit
import RxSwift
class AddTaskViewController: UIViewController {

    // Create a publish subject - it can emit and subscribe
    private let taskSubject = PublishSubject<Task>()
    
    // OBserbvble of the Task should be accesable outside of this controller
    var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObservable()
    }
    
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
        
        // Crate random id
        let randID =  randomString(length: 6)
        
        // Create a task
        let task = Task(title: title, priority: priority, id: randID)
        
        // Add task to the subject
        taskSubject.onNext(task)
        
        // Dismiss this screen
        _ = navigationController?.popViewController(animated: true)
    }
    
    private func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}
