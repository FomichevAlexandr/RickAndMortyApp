//
//  LocationScreenAssembly.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 14.06.2021.
//

import UIKit

class LocationScreenAssembly
{
    static func build(storage: ILocationStorage) -> UIViewController {
        let networkManager = NetworkManager()
        let interactor = LocationScreenInteractor(networkManager: networkManager, storage: storage)
        let presenter = LocationScreenPresenter(interactor: interactor)
        let tableAdapter = LocationScreenTableAdapter()
        let viewController = LocationScreenViewController(presenter: presenter, tableAdapter: tableAdapter)
        return viewController
    }
}
