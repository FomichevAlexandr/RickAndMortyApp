//
//  CharacterScreenPresenter.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 12.06.2021.
//
import UIKit

final class CharacterScreenPresenter
{
    private weak var characterView: ICharacterScreenView?
    private var interactor: ICharacterScreenInteractor
    
    init(interactor: ICharacterScreenInteractor) {
        self.interactor = interactor
    }
    
    private func updateView(characters: [CharacterModel]) {
        DispatchQueue.main.async {
            let charactersViewModel = self.getConverteModel(characters: characters)
            self.characterView?.update(vm: charactersViewModel)
        }
    }
    
    private func getConverteModel(characters: [CharacterModel]) -> [CharacterScreenViewModel] {
        var model = [CharacterScreenViewModel]()
        for character in characters {
            if let locationPath = character.locationPath {
                if let data = self.interactor.getImageData(filePath: locationPath) {
                    if let image = UIImage(data: data) {
                        let characterViewModel = CharacterScreenViewModel(name: character.name, species: character.species, image: image)
                        model.append(characterViewModel)
                    }
                    else {
                        print("Could not make image from data")
                    }
                }
                else {
                    print("Could not recieve file patha from Interactor")
                }
            }
            else {
                print("Character has not location path")
            }
        }
        return model
    }
    
}


extension CharacterScreenPresenter: ICharacterScreenPresenter
{
    func viewDidLoad(characterScreenView: ICharacterScreenView) {
        self.characterView = characterScreenView
        self.characterView?.completeDownloadButtonAction { [weak self] in
            self?.interactor.getModelWithNewCharacter(completion: { characters in
                self?.updateView(characters: characters)
            })
        }
        self.characterView?.completeDeleteButtonAction { [weak self] in
            self?.interactor.deleteAllCharacters(completion: { characters in
                self?.updateView(characters: characters)
            })
        }
        self.updateView(characters: self.interactor.getModel())
    }

}

