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
    var locationPath: String?
    
    init(id: Int, name: String, species: String, image: String, locationPath:String ) {
        self.id = id
        self.name = name
        self.species = species
        self.image = image
        self.locationPath = locationPath
    }
    
    init?(character: Characters) {
        self.id = Int(character.id)
        guard let name = character.name, let species = character.species, let image = character.image, let locationPath = character.locationPath else { return nil }
        self.name = name
        self.species = species
        self.image = image
        self.locationPath = locationPath
    }
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case name
        case species
        case image
    }
}
