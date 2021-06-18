//
//  ICharacterScreenView.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 18.06.2021.
//


protocol ICharacterScreenView: AnyObject
{
    func update(vm: [CharacterScreenViewModel])
    func completeDownloadButtonAction(buttonAction: @escaping (() -> Void))
    func completeDeleteButtonAction(buttonAction: @escaping (() -> Void))
}
