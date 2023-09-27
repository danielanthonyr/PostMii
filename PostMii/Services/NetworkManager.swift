//
//  NetworkManager.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-26.
//

import Foundation

class NetworkManager {
    func loadTodos(completion: @escaping(Result<[Todo]?, Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, result, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                    return
                }
            }
            
            if let data = data {
                let todos = try? JSONDecoder().decode([Todo].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(todos))
                }
            }
        }
        task.resume()
    }
}
