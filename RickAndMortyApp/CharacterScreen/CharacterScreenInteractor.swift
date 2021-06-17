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
    func getData(filePath: String) -> Data?
}

final class CharacterScreenInteractor
{
    private let networkManager: INetworkmanager
    private var urlString = "https://rickandmortyapi.com/api/character/"
    private var characters: [CharacterModel]
    private let storage: ICharacterStorage
    init(networkManager: INetworkmanager, storage: ICharacterStorage) {
        self.characters = []
        self.networkManager = networkManager
        self.storage = storage
    }
    
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
                    self?.storage.saveCharacter(character: character, completion: {
                        if let characters = self?.characters{
                            completion(characters)
                        }
                    })
                case .failure(let error):
                    print(error)
                }
        })
    }
}

extension CharacterScreenInteractor: ICharacterScreenInteractor
{
    func getData(filePath: String) -> Data? {
        let fileSavePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filePath)
        return try? Data(contentsOf: fileSavePath)
    }
    
    func getModel() -> [CharacterModel] {
        self.characters = self.storage.getCharacters()
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
