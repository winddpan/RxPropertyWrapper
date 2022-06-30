import RxSwift

public protocol _RxObservableType {
    associatedtype Element
}

extension Observable: _RxObservableType {}
extension PrimitiveSequence: _RxObservableType {}
extension Infallible: _RxObservableType {}

#if canImport(RxCocoa)
import RxCocoa

extension Driver: _RxObservableType {}
extension ControlEvent: _RxObservableType {}
#endif
