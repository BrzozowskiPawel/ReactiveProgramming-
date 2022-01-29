//
//  ViewController.swift
//  CombineApp
//
//  Created by Paweł Brzozowski on 29/01/2022.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var allowsMessagesSwitch: UISwitch!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    // Publisher to use when it's allowed to send messages
    // To do this use property wrapper publish - this will allow to add publisher to the property
    @Published var canSendMessages:Bool = false
    
    // Any cancelable help with memory menagment - it's simillar to disposeBag in RxSwift
    // It calls cancel when VC deinit and make sure subscriptions are temirnated
    private var switchSubscriber: AnyCancellable?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProcessesChain()
    }

    func setupProcessesChain() {
        // Connect subscriber with a publisher.
        // Switch subscriber with canSendMessgaes publisher
        
        // Want to receive element from the publsiher on main thread and assign specyfic keyPath on button.
        // keyPath should be isEnabled to enable send button.
        switchSubscriber = $canSendMessages.receive(on: DispatchQueue.main, options: nil).assign(to: \.isEnabled, on: sendButton)
        
        
        // Setup messages
        // MessagePublisher:
        let messagePublisher = NotificationCenter.Publisher(center: .default, name: .newMessage).map {notification -> String? in
            return(notification.object as? Message)?.content ?? ""
        }
        
        // messageSubscriber:
        // Talk to the messageLabel text property
        let messageSubscriber = Subscribers.Assign(object: messageLabel, keyPath: \.text)
    
        
        messagePublisher.subscribe(messageSubscriber)
    }
    
    
    @IBAction func didSwitch(_ sender: UISwitch) {
        // Change the canSendMessages to state of button
        canSendMessages = sender.isOn
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        // create a message
        let message = Message(content: "The current time is \(Date())", author: "me 🥰")
    
        // To send message we have to use notification center
        // notifcaion name havee been already created
        NotificationCenter.default.post(name: .newMessage, object: message)
    }
    
}

struct Message {
    let content: String
    let author: String
}

extension Notification.Name {
    static let newMessage = Notification.Name("newMessage")
}
