//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 12.06.2021.
//
import Foundation

class CharacterModel: Decodable
{
    let id: Int
    let name: String
    let species: String
    let image: String
    var locationPath: URL?
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case name
        case species
        case image
    }
}
