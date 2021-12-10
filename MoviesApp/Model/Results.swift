//
//  Results.swift
//  MoviesApp

import Foundation

struct Results: Codable {
    let results: [Movie]
    let page: Int
    let totalPages: Int
    let totalResults: Int
}
