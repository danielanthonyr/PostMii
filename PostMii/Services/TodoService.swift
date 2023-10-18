//
//  TodoService.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-12.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

protocol TodoServiceProtocol {
    func getTodos(completion: @escaping (Result<[Todo]?, Error>) -> Void)
    func markTodoAsCompleted(withId: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func updateTodoInFirebaseDB(todo: Todo, completion: @escaping (Result<Bool, Error>) -> Void)
    func updateTodoInFirebaseDBWithImage(todo: Todo, imageData: Data, completion: @escaping (Result<Bool, Error>) -> Void)
}

class TodoService: TodoServiceProtocol {
    func getTodos(completion: @escaping (Result<[Todo]?, Error>) -> Void) {
        var todos = [Todo]()
        
        // Authenticate the user (replace with your authentication method)
        if let user = Auth.auth().currentUser {
            // User is authenticated, and you can get their UID
            let userUID = user.uid
            
            // Create a reference to the Firebase Realtime Database
            let databaseReference = Database.database().reference()
            
            // Create a reference to the user's "todos" node
            let userTodosRef = databaseReference.child("users").child(userUID).child("todos")
            
            // Query the database to retrieve the todos
            userTodosRef.observeSingleEvent(of: .value) { (snapshot) in
                if snapshot.exists() {
                    for child in snapshot.children {
                        if let childSnapshot = child as? DataSnapshot,
                           let todoData = childSnapshot.value as? [String: Any] {
                            // Access the todo data and do something with it
                            let timeStampId = todoData["timeStampId"] as? String
                            let todoPhotoURL = todoData["todoPhotoURL"] as? String
                            let name = todoData["name"] as? String
                            let description = todoData["description"] as? String
                            let firebaseDate = todoData["date"] as? String
                            
                            if let date = firebaseDate, let formattedDate = DateFormatter().getDateFromString(dateString: date) {
                                let todo = Todo(
                                    timeStampId: timeStampId ?? "",
                                    todoPhotoURL: todoPhotoURL ?? "",
                                    name: name ?? "",
                                    description: description ?? "",
                                    date:  formattedDate
                                )
                                
                                todos.append(todo)
                            } else {
                                print("error formatting the date")
                            }
                        }
                    }
                    
                    completion(.success(todos))
                } else {
                    // No todos found for the user
                    print("No todos found for the user.")
                }
            }
        } else {
            // User is not authenticated, handle accordingly
            // Example of creating an error object with a message
            let errorMessage = "No todos found for the user."
            let error = FirebaseError.message(errorMessage)
            
            completion(.failure(error))
        }
        
        completion(.success(todos))
    }
    
    func markTodoAsCompleted(withId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        if let user = Auth.auth().currentUser {
            
            let userUID = user.uid
            
            // Create a reference to the Firebase Realtime Database
            let databaseReference = Database.database().reference()
            
            print(withId)
            let itemReference = databaseReference.child("users").child(userUID).child("todos").child(withId)
            
            // Remove the item
            itemReference.removeValue { error, _ in
                if let error = error {
                    let firebaseError = FirebaseError.message(error.localizedDescription)
                    completion(.failure(firebaseError))
                } else {
                    completion(.success(true))
                }
            }
            
        } else {
            let firebaseError = FirebaseError.message("User is not authenticated")
            completion(.failure(firebaseError))
        }
    }
    
    func updateTodoInFirebaseDB(todo: Todo, completion: @escaping (Result<Bool, Error>) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        let formattedStringDate = dateFormatter.string(from: todo.date)
        
        if let user = Auth.auth().currentUser {
            
            let userUID = user.uid
            
            // Create a reference to the Firebase Realtime Database
            let databaseReference = Database.database().reference()
            
            let todoData = [
                "timeStampId" : todo.timeStampId,
                "name"    : todo.name ,
                "date" : formattedStringDate,
                "description"    : todo.description ]
            
            databaseReference.child("users").child(userUID).child("todos").child(todo.timeStampId).setValue(todoData) { (error, reference) in
                if let error = error {
                    let firebaseError = FirebaseError.message(error.localizedDescription)
                    completion(.failure(firebaseError))
                } else {
                    print("Todo added/updated to Firebase DB")
                    completion(.success(true))
                }
            }
            
        } else {
            let error = FirebaseError.message("User is not authenticated")
            completion(.failure(error))
        }
    }
    
    func updateTodoInFirebaseDBWithImage(todo: Todo, imageData: Data, completion: @escaping (Result<Bool, Error>) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        let formattedStringDate = dateFormatter.string(from: todo.date)
        
        if let user = Auth.auth().currentUser {
            
            let imageUUID = UUID().uuidString
            let storageRef = Storage.storage().reference().child("images/\(imageUUID).jpg")
            
            _ = storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                if let error = error {
                    completion(.failure(error))
    //                self.displayAlertMessage(title: "Image Upload Error", message: error.localizedDescription)
                } else {
                    // Image uploaded successfully, now store the download URL in Firebase Realtime Database
                    storageRef.downloadURL { (url, error) in
                        if let error = error {
                            completion(.failure(error))
    //                        self.displayAlertMessage(title: "Download URL error", message: error.localizedDescription)
                        } else if let downloadURL = url?.absoluteString, let user = Auth.auth().currentUser {
                            let userUID = user.uid
                            
                            // Create a reference to the Firebase Realtime Database
                            let databaseReference = Database.database().reference()
                            
                            let todoData = [
                                "timeStampId" : todo.timeStampId,
                                "todoPhotoURL" : downloadURL,
                                "name"    : todo.name,
                                "date" : formattedStringDate,
                                "description"    : todo.description ]
                            
                            databaseReference.child("users").child(userUID).child("todos").child(todo.timeStampId).setValue(todoData) { (error, reference) in
                                if let error = error {
                                    let firebaseError = FirebaseError.message(error.localizedDescription)
                                    completion(.failure(firebaseError))
                                } else {
                                    print("Todo with Photo added/updated to Firebase DB")
                                    completion(.success(true))
                                }
                            }
                        }
                    }
                }
            }
        } else {
            let error = FirebaseError.message("User is not authenticated")
            completion(.failure(error))
        }
    }
}
