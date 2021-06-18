//
//  CoreDataStorage.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 15.06.2021.
//

import Foundation
import CoreData

final class CoreDataStorage
{
    private let containerName = "RMDataBase"
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.containerName)
        container.loadPersistentStores(completionHandler: { (_, error) in
            guard let error = error as NSError? else { return }
            fatalError("Unresolved error \(error), \(error.userInfo)")
        })
        return container
    }()
}

extension CoreDataStorage: ICharacterStorage
{
    
    func getCharacters() -> [CharacterModel] {
        print(NSPersistentContainer.defaultDirectoryURL())
        let fetchRequest: NSFetchRequest<Characters> = Characters.fetchRequest()
        return (try? self.container.viewContext.fetch(fetchRequest).compactMap {CharacterModel(character: $0)}) ?? []
    }
    
    func saveCharacter(character: CharacterModel, completion: @escaping () -> Void) {
        self.container.performBackgroundTask { context in
            defer {
                DispatchQueue.main.async {
                    completion()
                }
            }
            let object = Characters(context: context)
            object.id = Int16(character.id)
            object.name = character.name
            object.species = character.species
            object.image = character.image
            object.locationPath = character.locationPath
            do {
                try context.save()
            } catch (let error) {
                print(error)
            }
        }
    }
    
    func deleteAllCharacters(completion: @escaping () -> Void) {
        print(NSPersistentContainer.defaultDirectoryURL())
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Characters")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try container.persistentStoreCoordinator.execute(deleteRequest, with: container.viewContext)
            completion()
        } catch (let error) {
            print(error)
        }
    }
    
}

extension CoreDataStorage: ILocationStorage
{
    func remove(id: Int, completion: @escaping ()->Void) {
        self.container.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<Locations> = Locations.fetchRequest()
            
            fetchRequest.predicate = NSPredicate(format: "\(#keyPath(Locations.uid)) = %@", String(Int16(id)))
            if let object = try? context.fetch(fetchRequest).first {
                context.delete(object)
                do {
                    try context.save()
                    DispatchQueue.main.async {
                        completion()
                    }
                } catch (let error) {
                    print(error)
                }
            }
        }
    }
    
    func getLocations() -> [LocationModel] {
        let fetchRequest: NSFetchRequest<Locations> = Locations.fetchRequest()
        return (try? self.container.viewContext.fetch(fetchRequest).compactMap {LocationModel(location: $0)}) ?? []
    }
    
    func saveLocation(location: LocationModel, completion: @escaping () -> Void) {
        self.container.performBackgroundTask { context in
            defer {
                DispatchQueue.main.async {
                    completion()
                }
            }
            let object = Locations(context: context)
            object.uid = Int16(location.id)
            object.name = location.name
            object.type = location.type
            do {
                try context.save()
            } catch (let error) {
                print(error)
            }
        }
    }
    
    
}


