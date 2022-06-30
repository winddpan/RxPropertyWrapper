#if canImport(RxRelay)
import RxRelay
import RxSwift

@propertyWrapper
public struct RxPublishRelay<S: _RxObservableType> {
    public let relay = PublishRelay<S.Element>()
    public let wrappedValue: S

    public func accept(_ event: S.Element) {
        relay.accept(event)
    }

    @available(*, unavailable, message: "Type error")
    public init() {
        fatalError()
    }

    public init<T>() where S == Observable<T> {
        wrappedValue = relay.asObservable()
    }

    public init() where S == Completable {
        wrappedValue = relay.asCompletable()
    }

    public init<T>() where S == Single<T> {
        wrappedValue = relay.asSingle()
    }

    public init<T>() where S == Maybe<T> {
        wrappedValue = relay.asMaybe()
    }

    public init<T>(onErrorJustReturn: T) where S == Infallible<T> {
        wrappedValue = relay.asInfallible(onErrorJustReturn: onErrorJustReturn)
    }

    public init<T>(onErrorFallbackTo: Infallible<T>) where S == Infallible<T> {
        wrappedValue = relay.asInfallible(onErrorFallbackTo: onErrorFallbackTo)
    }

    public init<T>(onErrorRecover: @escaping (_ error: Swift.Error) -> Infallible<T>) where S == Infallible<T> {
        wrappedValue = relay.asInfallible(onErrorRecover: onErrorRecover)
    }
}

#if canImport(RxCocoa)
import RxCocoa

public extension RxPublishRelay {
    init<T>(onErrorJustReturn: T) where S == Driver<T> {
        wrappedValue = relay.asDriver(onErrorJustReturn: onErrorJustReturn)
    }

    init<T>(onErrorDriveWith: Driver<T>) where S == Driver<T> {
        wrappedValue = relay.asDriver(onErrorDriveWith: onErrorDriveWith)
    }

    init<T>(onErrorRecover: @escaping (_ error: Swift.Error) -> Driver<T>) where S == Driver<T> {
        wrappedValue = relay.asDriver(onErrorRecover: onErrorRecover)
    }

    init<T>(onErrorJustReturn: T) where S == Signal<T> {
        wrappedValue = relay.asSignal(onErrorJustReturn: onErrorJustReturn)
    }

    init<T>(onErrorSignalWith: Signal<T>) where S == Signal<T> {
        wrappedValue = relay.asSignal(onErrorSignalWith: onErrorSignalWith)
    }

    init<T>(onErrorRecover: @escaping (_ error: Swift.Error) -> Signal<T>) where S == Signal<T> {
        wrappedValue = relay.asSignal(onErrorRecover: onErrorRecover)
    }
}
#endif

#endif
