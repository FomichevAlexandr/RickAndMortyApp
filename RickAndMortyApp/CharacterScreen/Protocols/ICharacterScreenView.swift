//
//  ICharacterScreenView.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 18.06.2021.
//


protocol ICharacterScreenView: AnyObject
{
    func update(vm: [CharacterScreenViewModel])
    func completeButtonAction(buttonAction: @escaping (() -> Void))
}
