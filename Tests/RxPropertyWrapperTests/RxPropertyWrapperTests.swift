import XCTest
import RxSwift
import RxCocoa
import RxRelay
@testable import RxPropertyWrapper

final class RxPropertyWrapperTests: XCTestCase {
    @RxPublishRelay var a: Observable<Int>
    @RxPublishSubject var b: Observable<Int>

    @RxPublishRelay var c: Completable
    @RxPublishSubject var d: Completable
    
    @RxPublishRelay(onErrorJustReturn: 123) var e: Signal<Int>
    @RxPublishSubject(onErrorJustReturn: 456) var f: Signal<Int>
    
    @RxBehaviorSubject(value: "default 1", onErrorJustReturn: "on error 1") var nameDriver: Driver<String>
    @RxBehaviorRelay(value: "default 2", onErrorJustReturn: "on error 2") var name2Driver: Driver<String>

    func testExample() throws {}
}
