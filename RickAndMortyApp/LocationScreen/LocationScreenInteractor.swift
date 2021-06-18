//
//  LocationScreenInteractor.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 15.06.2021.
//

import Foundation

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
                    self?.storage.saveLocation(location: location, completion: { [weak self] in
                        if let locations = self?.locations {
                            completion(locations)
                        }
                        else {
                            completion([])
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
    func removeLocation(locationID: Int, completion: @escaping () -> Void) {
        if let index = self.locations.firstIndex(where: {$0.id == locationID}) {
            self.locations.remove(at: index)
            self.storage.remove(id: locationID, completion: {
                completion()
            })
        } else {
            return
        }
       
    }
    
    func getModel() -> [LocationModel] {
        self.locations = self.storage.getLocations()
        return self.locations
    }
    
    func getModelWithNewLocation(completion: @escaping ([LocationModel]) -> Void) {
        self.loadLocation(completion: completion, locationURL: self.getRandomLocationURL())
    }
    
    
}
