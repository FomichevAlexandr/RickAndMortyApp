//
//  CharacterScreenPresenter.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 12.06.2021.
//
import UIKit

protocol ICharacterScreenPresenter {
    func viewDidLoad(characterScreenView: ICharacterScreenView)
}

final class CharacterScreenPresenter
{
    private var characters: [CharacterModel]
    private weak var characterView: ICharacterScreenView?
    private let networkManager: INetworkmanager
    private var urlString = "https://rickandmortyapi.com/api/character/"
    private var characterURLs: [String]?
    
    init(networkManager: INetworkmanager, characterURLs: [String]? = nil) {
        self.characters = []
        self.networkManager = networkManager
        self.characterURLs = characterURLs
    }
    
    //TODO: Посмотреть на weak self
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
    
    private func updateView() {
        self.characterView?.update(vm: self.getConverteModel())
    }
    
    private func getConverteModel() -> [CharacterScreenViewModel] {
        var model = [CharacterScreenViewModel]()
        for character in self.characters {
            if let locationPath = character.locationPath {
                do {
                    let data = try Data(contentsOf: locationPath)
                    if let image = UIImage(data: data) {
                        let characterViewModel = CharacterScreenViewModel(name: character.name, species: character.species, image: image)
                        model.append(characterViewModel)
                    } else {
                        print("Could not make image on given data")
                    }
                } catch (let error) {
                    print("Could not make data on given url")
                    print(error)
                }
            }
        }
        return model
    }
    
}


extension CharacterScreenPresenter: ICharacterScreenPresenter
{
    func viewDidLoad(characterScreenView: ICharacterScreenView) {
        self.characterView = characterScreenView
        self.characterView?.completeButtonAction { [weak self] in
            if let characterURL = self?.getRandomCharacterURL() {
                self?.loadCharacter(characterURL: characterURL)
            }
        }
        self.loadCharacters()
    }
    
    private func getRandomCharacterURL() -> String {
        let randomNumber = Int.random(in: 1...671)
        let characterURL = self.urlString + String(randomNumber)
        return characterURL
    }
    
    private func loadCharacters() {
        if let characterURLs = self.characterURLs {
            for characterURL in characterURLs {
                self.loadCharacter(characterURL: characterURL)
            }
        } else {
            return
        }
    }
}
