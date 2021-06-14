//
//  Location.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 12.06.2021.
//

struct LocationModel: Decodable
{
    let id: Int
    let name: String
    let type: String
    let residents: [String]
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case name
        case type
        case residents
    }
}
