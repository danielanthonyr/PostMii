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
    
    private(set) var todoCompletedError: Error?
    private(set) var currentDate: Date
    private let todoCardService: TodoServiceProtocol
    private(set) var todoCards: [Todo]
    private(set) var todoCardCellVMs: [TodoCardCellVM] {
        didSet {
            reloadCollectionView?()
        }
    }
    
    // MARK: - Initializers
    
    init(service: TodoServiceProtocol = TodoService()) {
        self.todoCardService = service
        self.todoCards = [Todo]()
        self.todoCardCellVMs = [TodoCardCellVM]()
        self.currentDate = Date()
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
    
    func setupData(todos: [Todo]) {
        self.todoCards = todos
        self.todoCards.sort { $0.date < $1.date } // sort todos by most recent first
        
        // create temp todoCardCellVM so we don't trigger the didSet multiple times for todoCardCellVMs
        var tempTodoCardCellVMs = [TodoCardCellVM]()
        
        for todo in self.todoCards {
            tempTodoCardCellVMs.append(createTodoCellVM(todo: todo))
        }
        
        self.todoCardCellVMs = tempTodoCardCellVMs // triggers the didSet
    }
    
    func getTodoCellVM(at index: Int) -> TodoCardCellVM {
        return todoCardCellVMs[index]
    }
    
    func markTodoAsCompleted(todo: TodoCardCellVM) {
        let todoTimeStampId = todo.timeStampId
        print("time stamp id: \(todoTimeStampId)")
        todoCardService.markTodoAsCompleted(withId: todoTimeStampId) { result in
            switch result {
            case .success(let result):
                if result {
                    // TODO: Figure out if i show a dialog to congratulate user on TODO or not
                    print("item was successfully removed")
                }
            case .failure(let error):
                self.todoCompletedError = error
            }
        }
    }
    
    private func createTodoCellVM(todo: Todo) -> TodoCardCellVM {
        return TodoCardCellVM(timeStampId: todo.timeStampId, name: todo.name, description: todo.description, date: todo.date)
    }
}
