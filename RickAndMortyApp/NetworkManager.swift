//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 12.06.2021.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case downloadError
    case getDataError
    case decodeError
    case makeDataError
}

protocol INetworkmanager
{
    func loadCharacter<T:Decodable>(urlString: String, modelType: T.Type, completion: @escaping (Result<T,Error>) -> Void)
    func loadImage(urlString: String, completion: @escaping (Result<URL, Error>) -> Void)
}
    
final class NetworkManager: INetworkmanager
{
    func loadCharacter<T:Decodable>(urlString: String, modelType: T.Type, completion: @escaping (Result<T,Error>) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.urlError))
            return
        }
        let urlRequest = URLRequest(url: url)
        let dataTask = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard let data = data else {
                if let error = error {
                    print(error)
                    completion(.failure(NetworkError.getDataError))
                }
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode(modelType, from: data)
                completion(.success(result))
            }
            catch (let error) {
                print(error)
                completion(.failure(NetworkError.decodeError))
            }
        })
        
        dataTask.resume()
    }
    //TODO: Обработка наличия файла возможна не тут
    func loadImage(urlString: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.urlError))
            return
        }
        let fileSavePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(url.lastPathComponent)
        if FileManager.default.fileExists(atPath: fileSavePath.path){
            print(fileSavePath)
            completion(.success(fileSavePath))
        }
        else {
            let urlRequest = URLRequest(url: url)
            let downloadTask = session.downloadTask(with: urlRequest, completionHandler: { tmpURL, response, error in
                if let location = tmpURL {
                    do {
                        try FileManager.default.copyItem(at: location, to: fileSavePath)
                        completion(.success(fileSavePath))
                    }
                    catch (let error) {
                        print(error)
                    }

                } else {
                    if let error = error {
                        print(error)
                    }
                    completion(.failure(NetworkError.downloadError))
                }
            })
            downloadTask.resume()
        }
        
    }
    
}
