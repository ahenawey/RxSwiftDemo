//
//  Worker.swift
//  RxSwiftDemo
//
//  Created by Ahmed Ali Henawey on 17/01/2018.
//  Copyright © 2018 Ahmed Ali Henawey. All rights reserved.
//

import RxSwift
import Foundation

class Worker {
    func request() -> Observable<Foundation.Data>  {
        return createNetworkObservable()
    }
    
    fileprivate func createNetworkObservable() -> Observable<Foundation.Data> {
        
        return Observable<Foundation.Data>.create { (observable) -> Disposable in
            let url = URL(string: "https://akshayanand.herokuapp.com/api/utc/?location=NL")
            let request = URLRequest(url: url!)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error == nil, let data = data {
                    observable.onNext(data)
                } else {
                    observable.onError(error!)
                }
                observable.onCompleted()
                }.resume()
            return Disposables.create()
        }
    }
}

extension ObservableType where E == Foundation.Data {
    func mapObject<O>(_ o: O.Type) -> Observable<O> where O : Decodable {
        return flatMap { (data) -> Observable<O> in
            do {
                let myString = try JSONDecoder().decode(o, from: data)
                return Observable.just(myString)
            } catch (let error) {
                return Observable.error(error)
            }
        }
    }
}
