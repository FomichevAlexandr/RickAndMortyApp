//
//  CharacterScreenInteractor.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 14.06.2021.
//

import Foundation

protocol ICharacterScreenInteractor
{
    func getModel() -> [CharacterModel]
    func getModelWithNewCharacter(completion: @escaping ([CharacterModel]) -> Void)
}

final class CharacterScreenInteractor
{
    private let networkManager: INetworkmanager
    private var urlString = "https://rickandmortyapi.com/api/character/"
    private var characters: [CharacterModel]

    init(networkManager: INetworkmanager) {
        self.characters = []
        self.networkManager = networkManager
        
    }
    
//    private func downloadCharacters(from characterURLs: [String]?) {
//        if let urls = characterURLs {
//            for url in urls {
//                if let character = loadCharacter(characterURL: url) {
//                    self.characters.append(character)
//                }
//            }
//        }
//    }
    //TODO; обработка ошибок
    private func loadCharacter(completion: @escaping ([CharacterModel]) -> Void, characterURL: String) {
        self.networkManager.loadCharacter(urlString: characterURL, modelType: CharacterModel.self, completion: { [weak self] result in
                switch result {
                case .success(let character):
                    self?.loadImage(completion: completion, character: character)
                case .failure(let error):
                    print(error)
                    
                }
        })
    }
    
    //TODO: Посмотреть на обработку ошибок
    private func loadImage(completion: @escaping ([CharacterModel]) -> Void, character: CharacterModel) {
        self.networkManager.loadImage(urlString: character.image, completion: {[weak self] result in
                switch result {
                case .success(let characterLocationURL):
                    character.locationPath = characterLocationURL
                    self?.characters.append(character)
                    if let characters = self?.characters{
                        completion(characters)
                    }
                case .failure(let error):
                    print(error)
                }
        })
    }
}

extension CharacterScreenInteractor: ICharacterScreenInteractor
{
    func getModel() -> [CharacterModel] {
        return self.characters
    }
    
    func getModelWithNewCharacter(completion: @escaping ([CharacterModel]) -> Void) {
        self.loadCharacter(completion: completion, characterURL: self.getRandomCharacterURL())
    }
    
    private func getRandomCharacterURL() -> String {
        let randomNumber = Int.random(in: 1...671)
        let characterURL = self.urlString + String(randomNumber)
        return characterURL
    }
    
}
