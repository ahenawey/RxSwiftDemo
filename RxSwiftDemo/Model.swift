//
//  Model.swift
//  RxSwiftDemo
//
//  Created by Ahmed Ali Henawey on 18/01/2018.
//  Copyright © 2018 Ahmed Ali Henawey. All rights reserved.
//

import Foundation
import RxSwift

struct Time: Decodable {
    let date: String
    let day: String
    let error: String
    let error_desc: String
    let error_no: String
    let hours: String
    let location: String
    let location_name: String
    let meridiem: String
    let minutes: String
    let month: String
    let seconds: String
    let year: String
}

enum TimeError: LocalizedError {
    case notFound
    
    var errorDescription: String?{
        switch self {
        case .notFound:
            return NSLocalizedString("No Time Found", comment: "")
        }
    }
}

extension ObservableType where E == [String: [Time]] {
    func strip() -> Observable<Time> {
        return flatMap({ (data) -> Observable<Time> in
            guard let time = data.first.flatMap({ $1.first }) else {
                return Observable.error(TimeError.notFound)
            }
            return Observable.just(time)
        })
    }
}
