//
//  ICharacterScreenInteractor.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 18.06.2021.
//
import Foundation

protocol ICharacterScreenInteractor
{
    func getModel() -> [CharacterModel]
    func getModelWithNewCharacter(completion: @escaping ([CharacterModel]) -> Void)
    func getImageData(filePath: String) -> Data?
}
