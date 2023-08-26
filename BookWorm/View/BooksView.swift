//
//  BooksView.swift
//  BookWorm
//
//  Created by Conner Glasgow on 8/26/23.
//

import SwiftUI

struct BooksView: View {
    @Environment(\.managedObjectContext) var moc
    
    @StateObject private var bookVM = BookViewModel()
    
    @State private var showingAddBookView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(bookVM.books, id: \.id) { book in
                    NavigationLink {
                        DetailView(book: book)
                            .environmentObject(bookVM)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                            
                            VStack {
                                Text(book.title ?? "No title")
                                    .font(.headline)
                                Text(book.author ?? "No author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .onAppear { bookVM.fetchBooks(context: moc) }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddBookView.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.accentColor)
                    }

                }
            }
            .sheet(isPresented: $showingAddBookView) { AddBookView() }
            .environmentObject(bookVM)
            .navigationTitle("Book Worm")
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            bookVM.delete(at: offset, context: moc)
        }
        
        bookVM.saveContext(moc)
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksView()
    }
}
