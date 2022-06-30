#if canImport(RxRelay)
import RxRelay
import RxSwift

@propertyWrapper
public struct RxBehaviorRelay<S: _RxObservableType> {
    public let relay: BehaviorRelay<S.Element>
    public let wrappedValue: S

    public func accept(_ event: S.Element) {
        relay.accept(event)
    }

    @available(*, unavailable, message: "Type error")
    public init() {
        fatalError()
    }

    public init<T>(value: T) where S == Observable<T> {
        relay = BehaviorRelay(value: value)
        wrappedValue = relay.asObservable()
    }

    public init<T>(value: T) where S == Single<T> {
        relay = BehaviorRelay(value: value)
        wrappedValue = relay.asSingle()
    }

    public init<T>(value: T) where S == Maybe<T> {
        relay = BehaviorRelay(value: value)
        wrappedValue = relay.asMaybe()
    }

    public init<T>(value: T, onErrorJustReturn: T) where S == Infallible<T> {
        relay = BehaviorRelay(value: value)
        wrappedValue = relay.asInfallible(onErrorJustReturn: onErrorJustReturn)
    }

    public init<T>(value: T, onErrorFallbackTo: Infallible<T>) where S == Infallible<T> {
        relay = BehaviorRelay(value: value)
        wrappedValue = relay.asInfallible(onErrorFallbackTo: onErrorFallbackTo)
    }

    public init<T>(value: T, onErrorRecover: @escaping (_ error: Swift.Error) -> Infallible<T>) where S == Infallible<T> {
        relay = BehaviorRelay(value: value)
        wrappedValue = relay.asInfallible(onErrorRecover: onErrorRecover)
    }
}

#if canImport(RxCocoa)
import RxCocoa

public extension RxBehaviorRelay {
    init<T>(value: T, onErrorJustReturn: T) where S == Driver<T> {
        relay = BehaviorRelay(value: value)
        wrappedValue = relay.asDriver(onErrorJustReturn: onErrorJustReturn)
    }

    init<T>(value: T, onErrorDriveWith: Driver<T>) where S == Driver<T> {
        relay = BehaviorRelay(value: value)
        wrappedValue = relay.asDriver(onErrorDriveWith: onErrorDriveWith)
    }

    init<T>(value: T, onErrorRecover: @escaping (_ error: Swift.Error) -> Driver<T>) where S == Driver<T> {
        relay = BehaviorRelay(value: value)
        wrappedValue = relay.asDriver(onErrorRecover: onErrorRecover)
    }

    init<T>(value: T, onErrorJustReturn: T) where S == Signal<T> {
        relay = BehaviorRelay(value: value)
        wrappedValue = relay.asSignal(onErrorJustReturn: onErrorJustReturn)
    }

    init<T>(value: T, onErrorSignalWith: Signal<T>) where S == Signal<T> {
        relay = BehaviorRelay(value: value)
        wrappedValue = relay.asSignal(onErrorSignalWith: onErrorSignalWith)
    }

    init<T>(value: T, onErrorRecover: @escaping (_ error: Swift.Error) -> Signal<T>) where S == Signal<T> {
        relay = BehaviorRelay(value: value)
        wrappedValue = relay.asSignal(onErrorRecover: onErrorRecover)
    }
}
#endif

#endif
