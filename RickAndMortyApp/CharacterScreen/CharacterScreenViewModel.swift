//
//  CharacterScreenViewModel.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 12.06.2021.
//

import UIKit
class CharacterScreenViewModel
{
    let name: String
    let species: String
    var image: UIImage
    
    init(name: String, species: String, image: UIImage) {
        self.name = name
        self.species = species
        self.image = image
    }
    
}
