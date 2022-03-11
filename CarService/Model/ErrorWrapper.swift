//
//  ErrorWrapper.swift
//  CarService
//
//  Created by sam on 3/7/22.
//  Code from Scrumdinger sample app
//  https://developer.apple.com/tutorials/app-dev-training/persisting-data

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error
    let guidance: String

    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
