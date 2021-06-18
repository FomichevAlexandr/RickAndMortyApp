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
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case name
        case type
    }
    
    init(id: Int, name: String, type: String ) {
        self.id = id
        self.name = name
        self.type = type
    }
    
    init?(location: Locations) {
        self.id = Int(location.uid)
        guard let name = location.name, let type = location.type else { return nil }
        self.name = name
        self.type = type
    }
}
