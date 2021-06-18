//
//  ILocationScreenInteractor.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 18.06.2021.
//

protocol ILocationScreenInteractor
{
    func getModel() -> [LocationModel]
    func getModelWithNewLocation(completion: @escaping ([LocationModel]) -> Void)
    func removeLocation(locationID: Int, completion: @escaping () -> Void)
}
