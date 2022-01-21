import UIKit
import RxSwift
import RxCocoa

//let disposeBag = DisposeBag()
//
//Observable.of("A","B","C").subscribe {
//    print($0)
//}.disposed(by: disposeBag)
//
//
//Observable<String>.create{ observer in
//    observer.onNext("A")
//    observer.onCompleted()
//    observer.onNext("?")
//    return Disposables.create()
//}.subscribe(onNext: { print($0)}, onError: { print($0) }, onCompleted: { print("completed")}, onDisposed: { print("Disposed")}).disposed(by: disposeBag)


/*
 PUBLISH SUBJECT
 */
//let disposeBag = DisposeBag()
//
//let subject = PublishSubject<String>()
//
//subject.onNext("Issue 1")
//
//subject.subscribe { event in
//    print(event)
//}
//
//subject.onNext("Issue 2")
//sleep(5)


/*
 BEHAVIOR SUBJECT - laway gives last value
 */

//let disposeBag = DisposeBag()
//
//let subject = BehaviorSubject(value: "Initial value")
//
//subject.onNext("Last Issue")
//
//// Last value
//subject.subscribe { event in
//    print(event)
//}
//
//subject.onNext("Issue 1")

/*
 REPLAY SUBJECT - lreplesy event based on buffer size
 */

//let disposeBag = DisposeBag()
//
//// Buffer size of 2 will replay 2 last values
//let subject = ReplaySubject<String>.create(bufferSize: 2)
//
//subject.onNext("Issue 1")
//subject.onNext("Issue 2")
//subject.onNext("Issue 3")
//
//subject.subscribe {
//    print($0)
//}
//
//subject.onNext("Issue 4")
//subject.onNext("Issue 5")
//subject.onNext("Issue 6")
//
//print("Subsription 2 ")
//
//subject.subscribe {
//    print($0)
//}

/*
 Behavior Relay - wraps a behavior subject and stores value in state
 */

let disposeBag = DisposeBag()

let relay = BehaviorRelay(value: ["Item 0"])

relay.accept(relay.value + ["Item 1"])

relay.asObservable().subscribe{
    print($0)
}


