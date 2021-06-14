//
//  LocationScreenAssembly.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 14.06.2021.
//

import UIKit

class LocationScreenAssembly
{
    static func build() -> UIViewController {
        let networkManager = NetworkManager()
        let presenter = LocationScreenPresenter(networkManager: networkManager)
        let tableAdapter = LocationScreenTableAdapter()
        let viewController = LocationScreenViewController(presenter: presenter, tableAdapter: tableAdapter)
        return viewController
    }
}
