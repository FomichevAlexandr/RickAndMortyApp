//
//  LocationScreenPresenter.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 14.06.2021.
//

import Foundation
protocol ILocationScreenPresenter: AnyObject
{
    func viewDidload(view: ILocationScreenView, tableAdapter: ILocationScreenTableAdapter)
}

final class LocationScreenPresenter
{
    private weak var tableAdapter: ILocationScreenTableAdapter?
    private var locations: [LocationModel]
    private let urlString = "https://rickandmortyapi.com/api/location/"
    private let networkManager: INetworkmanager
    private weak var locationView: ILocationScreenView?
    
    init(networkManager: INetworkmanager) {
        self.locations = []
        self.networkManager = networkManager
    }
    
    private func loadLocation() {
        let randomNumber = Int.random(in: 1...108)
        let locationURL = self.urlString + String(randomNumber)
        self.networkManager.loadCharacter(urlString: locationURL, modelType: LocationModel.self, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let location):
                    self?.locations.append(location)
                    self?.update()
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
    
    private func update() {
        self.tableAdapter?.update(locations: self.locations.map { LocationScreenViewModel(name: $0.name, type: $0.type) })
    }
    
}

extension LocationScreenPresenter: ILocationScreenPresenter
{
    func viewDidload(view: ILocationScreenView, tableAdapter: ILocationScreenTableAdapter) {
        self.locationView = view
        self.locationView?.completeButtonAction { [weak self] in
            self?.loadLocation()
        }
        self.tableAdapter = tableAdapter
    }
    
}
