//
//  FilterView.swift
//  GroceryList
//
//  Created by Keillor Jennings on 4/30/24.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject var manager : GroceryListManager
    var body: some View {
        NavigationView {
            Form {
                    ScrollView (.horizontal,showsIndicators: false){
                            ForEach(groceryType.allCases, id: \.rawValue) { item in
                                Button(action: {
                                    if manager.selectedFilterCategory.contains(item) {
                                        if let number = manager.selectedFilterCategory.firstIndex(of: item) {
                                            manager.selectedFilterCategory.remove(at: number)
                                        }
                                    } else {
                                        manager.selectedFilterCategory.append(item)
                                    }
                                }) {
                                    Text(item.rawValue).padding(5).background(manager.selectedFilterCategory.contains(item) ? .blue : .clear)
                                }.clipShape(Capsule()).foregroundColor(manager.selectedFilterCategory.contains(item) ? .white : .gray).overlay(Capsule().stroke(lineWidth: 1).foregroundColor(manager.selectedFilterCategory.contains(item) ? .blue : .gray))
                        }
                    
                    
                }
                Section(header: Text("Other Conditions")) {
                    Toggle(isOn: $manager.onlyUncomplete) {
                        Text("Show only incomplete")
                    }
                    Button(role: .destructive, action: {
                        manager.myList.removeAll(where: {$0.completed == true})
                    }) {
                        Label("Remove All Complete", systemImage: "eraser.line.dashed").foregroundColor(.red)
                    }
                    Button(action: {
                        manager.selectedFilterCategory.removeAll()
                        manager.onlyUncomplete = false
                    }){
                        Label("Unselect All Filters", systemImage: "xmark.circle")
                    }
                }
            }.navigationTitle("Filters & Options")
        }
    }
}
