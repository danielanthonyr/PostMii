//
//  HomeVM.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-05.
//

import Foundation

class HomeVM {
    
    // MARK: - Variables
    
    var reloadCollectionView: (() -> Void)?
    
    private let todoCardService: TodoServiceProtocol
    private(set) var todoCards: [TodoCard]
    private(set) var todoCardCellVMs: [TodoCardCellVM] {
        didSet {
            reloadCollectionView?()
        }
    }
    
    // MARK: - Initializers
    
    init(service: TodoServiceProtocol = TodoService()) {
        self.todoCardService = service
        self.todoCards = [TodoCard]()
        self.todoCardCellVMs = [TodoCardCellVM]()
    }
    
    // MARK: - Methods
    
    func getTodos() {
        todoCardService.getTodos { result in
            switch result {
            case .success(let todos):
                if let todos = todos {
                    self.setupData(todos: todos)
                } else {
                    print("getTodos() returned nil")
                }
            case .failure(let error):
                print("Error in getTodos() \(error.localizedDescription)")
            }
        }
    }
    
    func setupData(todos: [TodoCard]) {
        self.todoCards = todos
        
        // create temp todoCardCellVM so we don't trigger the didSet multiple times for todoCardCellVMs
        var tempTodoCardCellVMs = [TodoCardCellVM]()
        
        for todo in self.todoCards {
            tempTodoCardCellVMs.append(createTodoCellVM(todo: todo))
        }
        
        self.todoCardCellVMs = tempTodoCardCellVMs // triggers the didSet
    }
    
    func createTodoCellVM(todo: TodoCard) -> TodoCardCellVM {
        return TodoCardCellVM(id: todo.id, name: todo.name, description: todo.description, date: todo.date)
    }
    
    func getTodoCellVM(at indexPath: IndexPath) -> TodoCardCellVM {
        return self.todoCardCellVMs[indexPath.row]
    }
}