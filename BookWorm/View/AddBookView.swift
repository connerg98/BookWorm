//
//  AddBookView.swift
//  BookWorm
//
//  Created by Conner Glasgow on 8/26/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject private var bookVM: BookViewModel
    
    @State private var book = BookModel(title: "", author: "", rating: 1, review: "", genre: Genres.fantasy.rawValue)
    
    private let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $book.title)
                    TextField("Author", text: $book.author)
                    
                    Picker("Genre", selection: $book.genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $book.review)
                    RatingView(rating: $book.rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        bookVM.createBook(book, context: context)
                        
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
