//
//  KakaJSON+Ext.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/10.
//  Copyright © 2020 canshi. All rights reserved.
//

import Foundation

import Moya
import KakaJSON
import RxSwift

public extension Response {
    /// JSON -> Model
    func mapObject<T: Convertible>(_ type: T.Type) throws -> T {
        guard let object = data.kj.model(T.self) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }
    /// JSON -> ModelArray
    func mapArray<T: Convertible>(_ type: T.Type) throws -> [T] {
        guard let array = try mapJSON() as? [[String: Any]] else {
            throw MoyaError.jsonMapping(self)
        }
        guard let modelArray = array.kj.modelArray(type: T.self) as? [T] else {
            return []
        }
        return modelArray
    }
    /// JSON -> Model
    func mapObject<T: Convertible>(_ type: T.Type, atKeyPath keyPath: String) throws -> T {
        guard let object = ((try mapJSON() as? NSDictionary)?.value(forKeyPath: keyPath) as? NSDictionary)?.kj.model(T.self) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }
    /// JSON -> ModelArray
    func mapArray<T: Convertible>(_ type: T.Type, atKeyPath keyPath: String) throws -> [T] {
        guard let array = (try mapJSON() as? NSDictionary)?.value(forKeyPath: keyPath) as? [[String: Any]] else {
            throw MoyaError.jsonMapping(self)
        }
        return array.kj.modelArray(T.self)
    }
}

public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    /// JSON -> Model
    func mapObject<T: Convertible>(_ type: T.Type) -> Single<T> {
        return flatMap { response -> Single<T> in
            Single.just(try response.mapObject(type))
        }
    }
    /// JSON -> ModelArray
    func mapArray<T: Convertible>(_ type: T.Type) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            Single.just(try response.mapArray(type))
        }
    }
    /// JSON -> Model
    func mapObject<T: Convertible>(_ type: T.Type, atKeyPath keyPath: String) -> Single<T> {
        return flatMap { response -> Single<T> in
            Single.just(try response.mapObject(type, atKeyPath: keyPath))
        }
    }
    /// JSON -> ModelArray
    func mapArray<T: Convertible>(_ type: T.Type, atKeyPath keyPath: String) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            Single.just(try response.mapArray(type, atKeyPath: keyPath))
        }
    }
}

public extension ObservableType where Element == Response {
    /// JSON -> Model
    func mapObject<T: Convertible>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            Observable.just(try response.mapObject(type))
        }
    }
    /// JSON -> ModelArray
    func mapArray<T: Convertible>(_ type: T.Type) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            Observable.just(try response.mapArray(type))
        }
    }
    /// JSON -> Model
    func mapObject<T: Convertible>(_ type: T.Type, atKeyPath keyPath: String) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            Observable.just(try response.mapObject(type, atKeyPath: keyPath))
        }
    }
    /// JSON -> ModelArray
    func mapArray<T: Convertible>(_ type: T.Type, atKeyPath keyPath: String) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            Observable.just(try response.mapArray(type, atKeyPath: keyPath))
        }
    }
}


