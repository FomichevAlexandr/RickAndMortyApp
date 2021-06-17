//
//  ILocationStorage.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 15.06.2021.
//

protocol ILocationStorage
{
    func getLocations() -> [LocationModel]
    func saveLocation(location: LocationModel, completion: @escaping () -> Void)
}
