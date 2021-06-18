//
//  LocationScreenPresenter.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 14.06.2021.
//

import Foundation

final class LocationScreenPresenter
{
    private weak var tableAdapter: ILocationScreenTableAdapter?
    private var interactor: ILocationScreenInteractor
    private weak var locationView: ILocationScreenView?
    
    init(interactor: ILocationScreenInteractor) {
        self.interactor = interactor
    }
    
    private func update(model: [LocationModel]) {
        DispatchQueue.main.async {
            self.tableAdapter?.update(locations: model)
        }
    }
    
}

extension LocationScreenPresenter: ILocationScreenPresenter
{
    func onItemDelete(locationID: Int) {
        self.interactor.removeLocation(locationID: locationID, completion: { [weak self] in
            if let model = self?.interactor.getModel() {
                self?.update(model: model)
            }
        })
    }
    
    func viewDidload(view: ILocationScreenView, tableAdapter: ILocationScreenTableAdapter) {
        self.locationView = view
        self.locationView?.completeButtonAction { [weak self] in
            self?.interactor.getModelWithNewLocation(completion: { locations in
                self?.update(model: locations)
            })
        }
        self.tableAdapter = tableAdapter
        self.update(model: self.interactor.getModel())
    }
    
}
