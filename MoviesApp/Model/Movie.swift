//
//  Movie.swift
//  MoviesApp

import Foundation

struct Movie: Codable {
    let id: Int?
    let title: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let voteCount: Int?
    let voteAverage: Double?
    let releaseDate: String?
}
