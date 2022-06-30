import RxSwift

@propertyWrapper
public struct RxPublishSubject<S: _RxObservableType>: ObserverType {
    public let subject = PublishSubject<S.Element>()
    public let wrappedValue: S

    public func on(_ event: Event<S.Element>) {
        subject.on(event)
    }

    @available(*, unavailable, message: "Type error")
    public init() {
        fatalError()
    }

    public init<T>() where S == Observable<T> {
        wrappedValue = subject.asObservable()
    }

    public init() where S == Completable {
        wrappedValue = subject.asCompletable()
    }

    public init<T>() where S == Single<T> {
        wrappedValue = subject.asSingle()
    }

    public init<T>() where S == Maybe<T> {
        wrappedValue = subject.asMaybe()
    }

    public init<T>(onErrorJustReturn: T) where S == Infallible<T> {
        wrappedValue = subject.asInfallible(onErrorJustReturn: onErrorJustReturn)
    }

    public init<T>(onErrorFallbackTo: Infallible<T>) where S == Infallible<T> {
        wrappedValue = subject.asInfallible(onErrorFallbackTo: onErrorFallbackTo)
    }

    public init<T>(onErrorRecover: @escaping (_ error: Swift.Error) -> Infallible<T>) where S == Infallible<T> {
        wrappedValue = subject.asInfallible(onErrorRecover: onErrorRecover)
    }
}

#if canImport(RxCocoa)
import RxCocoa

public extension RxPublishSubject {
    init<T>(onErrorJustReturn: T) where S == Driver<T> {
        wrappedValue = subject.asDriver(onErrorJustReturn: onErrorJustReturn)
    }

    init<T>(onErrorDriveWith: Driver<T>) where S == Driver<T> {
        wrappedValue = subject.asDriver(onErrorDriveWith: onErrorDriveWith)
    }

    init<T>(onErrorRecover: @escaping (_ error: Swift.Error) -> Driver<T>) where S == Driver<T> {
        wrappedValue = subject.asDriver(onErrorRecover: onErrorRecover)
    }

    init<T>(onErrorJustReturn: T) where S == Signal<T> {
        wrappedValue = subject.asSignal(onErrorJustReturn: onErrorJustReturn)
    }

    init<T>(onErrorSignalWith: Signal<T>) where S == Signal<T> {
        wrappedValue = subject.asSignal(onErrorSignalWith: onErrorSignalWith)
    }

    init<T>(onErrorRecover: @escaping (_ error: Swift.Error) -> Signal<T>) where S == Signal<T> {
        wrappedValue = subject.asSignal(onErrorRecover: onErrorRecover)
    }
}
#endif
