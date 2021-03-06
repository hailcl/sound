//
//  RxSwiftExtensions.swift
//  PrintOrdering
//
//  Created by Tri on 11/30/15.
//  Copyright (c) 2015. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

// swiftlint:disable variable_name

func createObservable<T>(f: @escaping () -> T) -> Observable<T> {
    return Observable.create { observer in
        observer.on(Event.next(f()))
        observer.on(Event.completed)
        
        return AnonymousDisposable {}
    }.shareReplay(1)
}

extension Observable {
    class func error(error: Error) -> Observable<Element> {
        return Observable.create { observer in
            observer.onError(error)
            
            return AnonymousDisposable {}
        }.shareReplay(1)
    }
}

/**
    if condition return A else return B

    - Parameter condition:
    - Parameter a: Observable A
    - Parameter b: Observable B
 
    - Returns: return A if condition is true, otherwise B
*/
func iff<T>(condition: Observable<Bool>, a: Observable<T>, b: Observable<T>) -> Observable<T> {
    return condition.take(1).flatMapLatest { value -> Observable<T> in
        return value ? a : b
    }
}

extension DisposeBag {
    func addDisposables(_ array: [Disposable]) {
        for item in array {
            self.insert(item)
        }
    }
}

protocol Converter {
    associatedtype S
    associatedtype D
    
    func convert(_ s: S) -> D
    func convert(_ d: D) -> S
}

infix operator ~>

func ~> <T>(variable: Observable<T>, property: AnyObserver<T>) -> Disposable {
    return variable.bindTo(property)
}

func ~> <T>(variable: Property<T>, property: AnyObserver<T>) -> Disposable {
    return variable.bindTo(property)
}

func ~> <T>(variable: Property<T>, property: ControlProperty<T>) -> Disposable {
    return variable.bindTo(property)
}

func ~> <T, O: ObserverType>(event: ControlEvent<T>, property: O) -> Disposable where O.E == T {
    return event.subscribeNext { value in
        property.onNext(value)
    }
}

func ~> <T>(property: ControlProperty<T>, variable: Property<T>) -> Disposable {
    return property.subscribeNext { value in
        variable.value = value
    }
}

func ~> <T>(property: ControlProperty<T>, variable: Variable<T>) -> Disposable {
    return property.subscribeNext { value in
        variable.value = value
    }
}

infix operator <~>

func <~> <T>(variable: Property<T?>, property: ControlProperty<T>) -> Disposable {
    return property <~> variable
}

func <~> <T>(property: ControlProperty<T>, variable: Property<T?>) -> Disposable {
    let d1 = variable.subscribeNext { next in
        if let value = next {
            property.onNext(value)
        }
    }
    
    let d2 = property.subscribe(onNext: { value in
        variable.value = value
        }, onCompleted: {
            d1.dispose()
    })
    
    return StableCompositeDisposable.create(d1, d2)
}

func <~> (property: ControlProperty<String>, variable: Property<Int?>) -> Disposable {
    return twoWayBind(property, variable, converter: Converters.OptionalIntToString)
}

func <~> (property: ControlProperty<String>, variable: Property<Double?>) -> Disposable {
    return twoWayBind(property, variable, converter: Converters.OptionalDoubleToString)
}

func twoWayBind<S, D, C: Converter>(_ property: ControlProperty<S>, _ variable: Property<D>,
                converter: C) -> Disposable where C.S == S, C.D == D {
    
        let d1 = variable.subscribeNext { next in
            property.onNext(converter.convert(next))
        }
        
        let d2 = property.subscribe(onNext: { value in
            variable.value = converter.convert(value)
            }, onCompleted: {
                d1.dispose()
        })
        
        return StableCompositeDisposable.create(d1, d2)
}

struct OptionalDoubleToStringConverter: Converter {

    typealias S = String
    typealias D = Double?
    
    func convert(_ s: String) -> Double? {
        if s != "" {
            return Double(s)
        } else {
            return nil
        }
    }
    
    func convert(_ d: Double?) -> String {
        if let value = d {
            return NSString(format: "%.2f", value) as String
        } else {
            return ""
        }
    }
}

struct OptionalIntToStringConverter: Converter {
    typealias S = String
    typealias D = Int?
    
    func convert(_ d: Int?) -> String {
        if let value = d {
            return String(value)
        } else {
            return ""
        }
    }
    func convert(_ s: String) -> Int? {
        if s != "" {
            return Int(s)
        } else {
            return nil
        }
    }
}

struct Converters {
    static let OptionalIntToString = OptionalIntToStringConverter()
    static let OptionalDoubleToString = OptionalDoubleToStringConverter()
}

// swiftlint:enable variable_name
