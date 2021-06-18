//
//  CharacterScreenAssembly.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 13.06.2021.
//

import UIKit

final class CharacterScreenAssembly
{
    static func build(storage: ICharacterStorage) -> UIViewController {
        let networkManager = NetworkManager()
        let interactor = CharacterScreenInteractor(networkManager: networkManager, storage: storage)
        let presenter = CharacterScreenPresenter(interactor: interactor)
        let viewController = CharacterScreenViewController(presenter: presenter)
        return viewController
    }
}
