//
//  TaskTableViewCell.swift
//  ToDoListRx
//
//  Created by Paweł Brzozowski on 24/01/2022.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var currentTask: Task?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUpCell(currentTask task: Task) {
        
        // Set up task
        self.currentTask = task
        
        //
        titleLabel.text = task.title
        
        switch task.priority {
        case .high:
            priorityLabel.text = "High"
        case .medium:
            priorityLabel.text = "Medium"
        case .low:
            priorityLabel.text = "Low"
        }

    }

}
