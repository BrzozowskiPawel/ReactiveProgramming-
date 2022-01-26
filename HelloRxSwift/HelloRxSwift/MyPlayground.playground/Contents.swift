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

//let disposeBag = DisposeBag()
//
//let relay = BehaviorRelay(value: ["Item 0"])
//
//relay.accept(relay.value + ["Item 1"])
//
//relay.asObservable().subscribe{
//    print($0)
//}

// MARK: - OPERATORS

/*
 Ignore
 */
//
//let strikes = PublishSubject<String>()
//
//let dispodeBag = DisposeBag()
//
//// Subscibing, ignoring the event.
//strikes.ignoreElements().subscribe { _ in
//    print("[Subscribtion is called]")
//}.disposed(by: dispodeBag)
//
//strikes.onNext("A")
////  When calling event nothing is being shown. This is bacause of ignoreElement()
//
//strikes.onCompleted()
//// Hoever onCompleted will be still called: "[Subscribtion is called]" will be shown.



/*
 elementAt - gives particula value on particual index
 */

//let strikes = PublishSubject<String>()
//let disposeBag = DisposeBag()
//
//strikes.element(at: 2).subscribe(onNext: {
//    _ in print("You are out!")
//}).disposed(by: disposeBag)
//
//
//// Pass some events
//strikes.onNext("A")
//// After passin 1 vlaue subscribtion never fires
//
//strikes.onNext("B")
//// After passin 2 vlaues subscribtion never fires
//
//strikes.onNext("C")
//// After passing 3 values subscribtion fires.




/*
 filter - gives particula value when they are fullfil teh condition
 */

//let disposeBag = DisposeBag()
//
//Observable.of(1,2,3,4,5,6,7).filter{$0 % 2 == 0}.subscribe(onNext: {
//    print($0)
//}).disposed(by: disposeBag)



/*
 Skip(number) - skipping first <number> values
 */

//let disposeBag = DisposeBag()
//
//Observable.of("A", "B", "C", "D", "E", "F").skip(3).subscribe(onNext: {
//    print($0)
//}).disposed(by: disposeBag)



/*
 Skip While (logic ) - skipping values taht fulfil this condition, ocne condition false then all next values arent skipped
 */

//let disposeBag = DisposeBag()
//
//Observable.of(2,2,3,4,6).skipWhile{$0 % 2 == 0}.subscribe(onNext: {
//    print($0)
//}).disposed(by: disposeBag)



/*
 Skip Until (logic ) - operator will be waiting to trigger. After trigger are values will be let thrugh
*/

//let disposeBag = DisposeBag()
//
//let subject = PublishSubject<String>()
//
//let trigger = PublishSubject<String>()
//
//subject.skip(until: trigger).subscribe(onNext: {
//    print($0)
//}).disposed(by: disposeBag)
//
//subject.onNext("A")
//subject.onNext("B")
//subject.onNext("C")
//
//// Nothing is printed, until pass to trigger
//
//trigger.onNext("TRIGGERING")
//
//subject.onNext("subject after trigger")
//// After triggernign we can see action on subject



/*
 Take - take<number> items from sequence for ex. <1,2,3,4> take(3) -> <1,2,3>
*/

//let disposeBag = DisposeBag()
//
//Observable.of(1,2,3,4,5).take(3).subscribe(onNext: {
//    print($0)
//}).disposed(by: disposeBag)


/*
 TakeWhile - take<logic> items from sequence until condition is true
*/

//let disposeBag = DisposeBag()
//
//Observable.of(2,4,6,1,8,3,4,6).takeWhile{$0 % 2 == 0}.subscribe(onNext: {
//    print($0)
//}).disposed(by: disposeBag)



/*
 TakeUntil - take<trigger> items from sequence until something is triggered. After that do not take
*/

//let disposeBag = DisposeBag()
//
//let subject = PublishSubject<String>()
//
//let trigger = PublishSubject<String>()
//
//subject.takeUntil(trigger).subscribe(onNext: {
//    print($0)
//}).disposed(by: disposeBag)
//
//subject.onNext("A")
//subject.onNext("B")
//subject.onNext("C")
//// Values above are being printed
//
//trigger.onNext("Triggering")
//// TRIGGERNIG
//
//subject.onNext("D")
//subject.onNext("E")
// Values below triggernign aren't being printed 





// TANSFORMING OPERATORS


/*
 TO Array - retrun array
 */

//let disposaeBag = DisposeBag()
//Observable.of(12,3,4,5).toArray().subscribe({
//    print($0)
//}).disposed(by: disposaeBag)


/*
 Map - like a normal map
 
*/

//let disposaeBag = DisposeBag()
//Observable.of(12,3,4,5).map {
//    return $0 * 2
//}.subscribe(onNext: {
//    print($0)
//}).disposed(by: disposaeBag)




/*
 Flat Map - project  aobservable and flattern it to target observable
*/

let disposaeBag = DisposeBag()

struct Student {
    var score: BehaviorRelay<Int>
}

let john = Student(score: BehaviorRelay(value: 75))
let mary = Student(score: BehaviorRelay(value: 90))

let student = PublishSubject<Student>()

student.asObservable().flatMap { $0.score.asObservable() }.subscribe(onNext: {
    print($0)
}).disposed(by: disposaeBag)

student.onNext(john)

john.score.accept(100)

