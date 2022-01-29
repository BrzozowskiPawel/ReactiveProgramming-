import UIKit
import Combine


enum WeatherError: Error {
    case thingsJustHappen
}

// Code for subscriber for checking if temp if above 25
// PassthroughSubject is thcniclai publsiher coz it publish cchanges
let weatherPublisher = PassthroughSubject<Int, WeatherError>()

// Atach publsiher to the subsciber
let subscriber = weatherPublisher.filter{$0 > 25}.sink { error in
    print("Error: \(error)")
} receiveValue: { value in
    print("A summer day of \(value) *C")
}


// Handle different kind of events
let anotherSubscriber = weatherPublisher.handleEvents { subscriptions in
    print("New subscription \(subscriptions)")
} receiveOutput: { output in
    print("New value: Output \(output)")
} receiveCompletion: { error in
    print("Subscription completed with potential error \(error)")
} receiveCancel: {
    print("Subscriptionc canceled")
} receiveRequest: { value in
    print("Subscriber received value: \(value)")
}.sink { error in
    print("SINK error \(error)")
} receiveValue: { value in
    print("Subscriber received value: \(value) (sink)")
}



// Code for weather publisher to send temp values
weatherPublisher.send(10)
weatherPublisher.send(20)
weatherPublisher.send(30)
weatherPublisher.send(40)

// Adding a error
weatherPublisher.send(completion: Subscribers.Completion<WeatherError>.failure(.thingsJustHappen))

weatherPublisher.send(50)


