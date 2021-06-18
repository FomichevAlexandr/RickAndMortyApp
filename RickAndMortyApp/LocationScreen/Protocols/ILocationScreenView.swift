//
//  ILocationScreenView.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 18.06.2021.
//

import Foundation

protocol ILocationScreenView: AnyObject
{
    func completeButtonAction(buttonAction: @escaping (() -> Void))
}
