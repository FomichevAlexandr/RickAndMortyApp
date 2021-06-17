//
//  ICharacterStorage.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 15.06.2021.
//

protocol ICharacterStorage
{
    func getCharacters() -> [CharacterModel]
    func saveCharacter(character: CharacterModel,  completion: @escaping () -> Void)
    func deleteAllCharacters(completion: @escaping () -> Void) 
}
