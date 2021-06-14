//
//  CharacterScreenInteractor.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 14.06.2021.
//

import Foundation

final class CharacterScreenInteractor
{
    private let networkManager: INetworkmanager
    private var urlString = "https://rickandmortyapi.com/api/character/"
    private var characterURLs: [String]?
    
    private func loadCharacter(characterURL: String) {
        self.networkManager.loadCharacter(urlString: characterURL, modelType: CharacterModel.self, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let character):
                    self?.loadImage(character: character)
                case .failure(let error):
                    print(error)
                    switch error {
                    case NetworkError.urlError:
                        print(error)
                    case NetworkError.getDataError:
                        print(error)
                    case NetworkError.decodeError:
                        print(error)
                    default:
                        print(error)
                    }
                }
            }
        })
    }
    
    //TODO: Посмотреть на обработку ошибок
    private func loadImage(character: CharacterModel) {
        self.networkManager.loadImage(urlString: character.image, completion: {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let characterLocationURL):
                    character.locationPath = characterLocationURL
                    self?.characters.append(character)
                    self?.updateView()
                case .failure(let error):
                    print(error)
                    switch error {
                    case NetworkError.urlError:
                        print(error)
                    case NetworkError.downloadError:
                        print(error)
                    default:
                        print(error)
                    }
                }
            }
            
        })
    }
}
