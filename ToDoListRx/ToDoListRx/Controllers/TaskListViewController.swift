//
//  TaskListViewController.swift
//  ToDoListRx
//
//  Created by Paweł Brzozowski on 24/01/2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController {

    @IBOutlet weak var pioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    private var tasks = BehaviorRelay<[Task]>(value: [])
    private var filteredTasks = [Task]()
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the tableView
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}

// MARK: - tabelView functions
extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTaskSegue" {
            if let addVC = segue.destination as? AddTaskViewController {
                // Subscribe on this observable
                addVC.taskSubjectObservable.subscribe(onNext: { [unowned self] task in
                    
//                    // Get the selected (on the segemntedController0 priority
//                    let priority = Priority(rawValue: self.pioritySegmentedControl.selectedSegmentIndex - 1)
                    
                    // Existing list of tasks
                    let existingTaskts = self.tasks.value
                    
                    // Add new task to the array of tasks
                    self.tasks.accept(existingTaskts + [task])
                    
//                    // Call filtering
//                    self.filterTasks(by: priority)
                    
                }).disposed(by: disposeBag)
            }
        }
    }
    
    @IBAction func priorityValueChanged(segmnetedControl: UISegmentedControl) {
        // Get the selected (on the segemntedController0 priority
        let priority = Priority(rawValue: self.pioritySegmentedControl.selectedSegmentIndex - 1)
        
        // Call filtering
        self.filterTasks(by: priority)
    }
    
    private func filterTasks(by priority: Priority?) {
        // All priorities
        if priority == nil {
            self.filteredTasks = self.tasks.value
        }
        else {
            // Get only task that have this priority
            self.tasks.map { tasks in
                return tasks.filter{$0.priority == priority!}
            }.subscribe(onNext: { [weak self] tasks in
                self?.filteredTasks = tasks
                print(tasks)
            }).disposed(by: disposeBag)
        }
    }
}
