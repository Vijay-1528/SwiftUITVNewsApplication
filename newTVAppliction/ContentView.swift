//
//  ContentView.swift
//  newTVAppliction
//
//  Created by VIJAY M on 21/03/23.
//

import SwiftUI
import CoreData

class Show: ObservableObject {
    var id = UUID()
    
    var title: String
    var episode: String
    var description: String
    var genre: String
    @Published var showingInfo = false
    init(title: String, episode: String, description: String, genre: String) {
        self.title = title
        self.episode = episode
        self.description = description
        self.genre = genre
    }
    
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var shows = [Show(title: "tvOS", episode: "01 - Build a TV App Clone", description: "Build your first tvOS application with swiftUI", genre: "For fans of Apps"), Show(title: "macOS", episode: "01 - Build a Notebook App", description: "Build your first macOS application with swiftUI", genre: "For fans of Apps"), Show(title: "watchOS", episode: "01 - Build a Countdown App", description: "Build your first watchOS application with swiftUI", genre: "For fans of Apps"),Show(title: "tvOS", episode: "01 - Build a TV App Clone", description: "Build your first tvOS application with swiftUI", genre: "For fans of Apps"), Show(title: "macOS", episode: "01 - Build a Notebook App", description: "Build your first macOS application with swiftUI", genre: "For fans of Apps"), Show(title: "watchOS", episode: "01 - Build a Countdown App", description: "Build your first watchOS application with swiftUI", genre: "For fans of Apps"),Show(title: "tvOS", episode: "01 - Build a TV App Clone", description: "Build your first tvOS application with swiftUI", genre: "For fans of Apps"), Show(title: "macOS", episode: "01 - Build a Notebook App", description: "Build your first macOS application with swiftUI", genre: "For fans of Apps"), Show(title: "watchOS", episode: "01 - Build a Countdown App", description: "Build your first watchOS application with swiftUI", genre: "For fans of Apps")]
    
    @State var currentlyShowingIndex = 0
    
    let navigationIcon = ["house", "checkmark.rectangle", "rectangle.stack", "magnifyingglass", "person"]
    
    let genres = ["Apps", "Web", "Machine Learning", "Games", "Python", "JavaScript", "Android", "Unreal", "Bura Tech"]
    
    var body: some View {
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
        
        ZStack {
            Image("NewBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .brightness(-0.35)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            VStack {
                HStack {
                    ForEach (navigationIcon, id: \.self) { icons in
                        Image(systemName: icons)
                    }
                    Spacer()
                    Text("New TV Application SwiftUI")
                }.font(.title)
                    .padding(70)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(genres, id: \.self) { genre in
                            Button(action: {}) {
                                Text(genre)
                                    .padding()
                                self.currentlyShowingIndex = 0
                            }
                        }
                    }
                }.padding(.horizontal, 50)
                
                HStack {
                    ScrollView() {
                        VStack (alignment: .leading, spacing: 15) {
                            ForEach(0..<shows.count, id: \.self) { counts in
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 1.0)) {
                                        shows[counts].showingInfo
                                            .toggle()
                                        self.currentlyShowingIndex = counts
                                    }
                                }) {
                                    Text(shows[counts].title)
                                        .font(.title)
                                        .padding(.horizontal, 15)
                                        .foregroundColor(self.currentlyShowingIndex == counts ? .primary : .secondary)
                                }.padding(20)
                                .buttonStyle(.plain)
                                if self.currentlyShowingIndex == counts {
                                    VStack(alignment: .leading, spacing: 15) {
                                        Text("Start Watching")
                                            .bold()
                                            .font(.caption2)
                                            .kerning(1)
                                        Text(self.shows[self.currentlyShowingIndex].episode)
                                            .bold()
                                        Text(self.shows[self.currentlyShowingIndex].description)
                                            .foregroundColor(.accentColor)
                                        Text(self.shows[self.currentlyShowingIndex].genre)
                                            .bold()
                                            .font(.caption)
                                            .foregroundColor(.accentColor)
                                    }.padding(.horizontal, 100)
                                }
                            }
                        }
                    }
                    Spacer()
                    VStack {
                        Spacer()
                        Text("Click to see the Details")
                            .foregroundColor(.primary)
                    }
                }.padding(100)
            }
//            .padding(.vertical, 100)
        }.font(.body)
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
