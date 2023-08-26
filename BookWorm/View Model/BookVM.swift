//
//  BookVM.swift
//  BookWorm
//
//  Created by Conner Glasgow on 8/26/23.
//

import Foundation
import CoreData


class BookViewModel: ObservableObject {
    @Published public var books: [Book] = []
    
    func fetchBooks(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        
        do {
            books = try context.fetch(fetchRequest)
        } catch {
            fatalError("ERROR; \(error.localizedDescription)")
        }
    }
    
    func book(at index: Int) -> Book {
        guard index < books.count && index > -1 else { fatalError("ERROR; index out of bounds") }
        
        return books[index]
    }
    
    func indexOf(_ book: Book) -> Int? {
        guard let index = books.firstIndex(of: book) else { return nil }
        
        return index
    }
    
    func createBook(_ book: BookModel, context: NSManagedObjectContext) {
        let newBook = Book(context: context)
        newBook.id = UUID()
        
        newBook.title = book.title
        newBook.author = book.author
        newBook.genre = book.genre
        newBook.rating = book.rating
        newBook.review = book.review
        
        books.append(newBook)
        
        saveContext(context)
    }
    
    func editBook(_ book: BookModel, context: NSManagedObjectContext) {
        guard let oldBook = books.first(where: { $0.id == book.id }) else { createBook(book, context: context) ; return }
        
        oldBook.title = book.title
        oldBook.author = book.author
        oldBook.genre = book.genre
        oldBook.rating = book.rating
        oldBook.review = book.review
        
        saveContext(context)
    }
    
    func delete(at index: Int, context: NSManagedObjectContext) {
        let book = book(at: index)
        
        books.remove(at: index)
        
        context.delete(book)
    }
    
    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            fatalError("ERROR; \(error.localizedDescription)")
        }
    }
}
