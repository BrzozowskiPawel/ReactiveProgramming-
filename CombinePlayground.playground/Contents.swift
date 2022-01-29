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


// Code for weather publisher to send temp values
weatherPublisher.send(10)
weatherPublisher.send(20)
weatherPublisher.send(30)
weatherPublisher.send(40)
weatherPublisher.send(50)


