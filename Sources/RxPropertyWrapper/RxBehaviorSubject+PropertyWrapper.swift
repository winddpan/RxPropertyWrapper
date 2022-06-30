import RxSwift

@propertyWrapper
public struct RxBehaviorSubject<S: _RxObservableType>: ObserverType {
    public let subject: BehaviorSubject<S.Element>
    public let wrappedValue: S

    public func on(_ event: Event<S.Element>) {
        subject.on(event)
    }

    @available(*, unavailable, message: "Type error")
    public init() {
        fatalError()
    }

    public init<T>(value: T) where S == Observable<T> {
        subject = BehaviorSubject(value: value)
        wrappedValue = subject.asObservable()
    }

    public init<T>(value: T) where S == Single<T> {
        subject = BehaviorSubject(value: value)
        wrappedValue = subject.asSingle()
    }

    public init<T>(value: T) where S == Maybe<T> {
        subject = BehaviorSubject(value: value)
        wrappedValue = subject.asMaybe()
    }

    public init<T>(value: T, onErrorJustReturn: T) where S == Infallible<T> {
        subject = BehaviorSubject(value: value)
        wrappedValue = subject.asInfallible(onErrorJustReturn: onErrorJustReturn)
    }

    public init<T>(value: T, onErrorFallbackTo: Infallible<T>) where S == Infallible<T> {
        subject = BehaviorSubject(value: value)
        wrappedValue = subject.asInfallible(onErrorFallbackTo: onErrorFallbackTo)
    }

    public init<T>(value: T, onErrorRecover: @escaping (_ error: Swift.Error) -> Infallible<T>) where S == Infallible<T> {
        subject = BehaviorSubject(value: value)
        wrappedValue = subject.asInfallible(onErrorRecover: onErrorRecover)
    }
}

#if canImport(RxCocoa)
import RxCocoa

public extension RxBehaviorSubject {
    init<T>(value: T, onErrorJustReturn: T) where S == Driver<T> {
        subject = BehaviorSubject(value: value)
        wrappedValue = subject.asDriver(onErrorJustReturn: onErrorJustReturn)
    }

    init<T>(value: T, onErrorDriveWith: Driver<T>) where S == Driver<T> {
        subject = BehaviorSubject(value: value)
        wrappedValue = subject.asDriver(onErrorDriveWith: onErrorDriveWith)
    }

    init<T>(value: T, onErrorRecover: @escaping (_ error: Swift.Error) -> Driver<T>) where S == Driver<T> {
        subject = BehaviorSubject(value: value)
        wrappedValue = subject.asDriver(onErrorRecover: onErrorRecover)
    }

    init<T>(value: T, onErrorJustReturn: T) where S == Signal<T> {
        subject = BehaviorSubject(value: value)
        wrappedValue = subject.asSignal(onErrorJustReturn: onErrorJustReturn)
    }

    init<T>(value: T, onErrorSignalWith: Signal<T>) where S == Signal<T> {
        subject = BehaviorSubject(value: value)
        wrappedValue = subject.asSignal(onErrorSignalWith: onErrorSignalWith)
    }

    init<T>(value: T, onErrorRecover: @escaping (_ error: Swift.Error) -> Signal<T>) where S == Signal<T> {
        subject = BehaviorSubject(value: value)
        wrappedValue = subject.asSignal(onErrorRecover: onErrorRecover)
    }
}
#endif
