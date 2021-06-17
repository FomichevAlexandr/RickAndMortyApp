//
//  LocationScreenInteractor.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 15.06.2021.
//

import Foundation
protocol ILocationScreenInteractor
{
    func getModel() -> [LocationModel]
    func getModelWithNewLocation(completion: @escaping ([LocationModel]) -> Void)
}

//TODO: добваить storage
final class LocationScreenInteractor
{
    private var locations: [LocationModel]
    private let urlString = "https://rickandmortyapi.com/api/location/"
    private let networkManager: INetworkmanager
    private let storage: ILocationStorage
    
    init(networkManager: INetworkmanager, storage: ILocationStorage) {
        self.locations = []
        self.networkManager = networkManager
        self.storage = storage
    }
    
    private func loadLocation(completion: @escaping ([LocationModel]) -> Void, locationURL: String) {
        self.networkManager.loadCharacter(urlString: locationURL, modelType: LocationModel.self, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let location):
                    self?.locations.append(location)
                    self?.storage.saveLocation(location: location, completion: {
                        if let locations = self?.locations {
                            completion(locations)
                        }
                    })
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
    
    private func getRandomLocationURL() -> String {
        let randomNumber = Int.random(in: 1...108)
        let locationURL = self.urlString + String(randomNumber)
        return locationURL
    }
    
}

extension  LocationScreenInteractor: ILocationScreenInteractor
{
    func getModel() -> [LocationModel] {
        self.locations = self.storage.getLocations()
        return self.locations
    }
    
    func getModelWithNewLocation(completion: @escaping ([LocationModel]) -> Void) {
        self.loadLocation(completion: completion, locationURL: self.getRandomLocationURL())
    }
    
    
}
