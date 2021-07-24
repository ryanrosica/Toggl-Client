//
//  SavedTimers.swift
//  Timer2
//
//  Created by Ryan Rosica on 5/15/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class SavedTimersStore: ObservableObject {

    
    enum SortedBy: String, CaseIterable {
        case project = "Project"
        case tags = "Tags"
        case none = "Custom"
    }
    
    @Published private(set) var saved = [TogglTimer]()
    @Published private(set) var filtered = [TogglTimer]()
    
    var filter: String = "" {
        didSet {
            if (filter == ""){
                filtered = saved
                return
            }
            
            filtered = saved.filter {
                return $0.searchableData.contains(filter)
            }
        }
    }
    
    
    @Published var sortedBy: SortedBy = .none
    let cloudData = CloudData.shared

    var sorted: [String: [TogglTimer]] {
        var result = [String: [TogglTimer]]()
        
        switch (sortedBy) {
            case .project:
                result = Dictionary(grouping: saved, by: {($0.project?.name ?? "")})
            case .tags:
                result = Dictionary(grouping: saved, by: {($0.tags?.sorted().joined(separator: ", ") ?? "")})
            case.none:
                result = ["": saved]
        }
        
        return result
    }
    

    
    
    func set(at index: Int, timer: TogglTimer) {
        if (index <= saved.endIndex && index >= 0) {
            saved[index] = timer
            write()
        }
    }
    
    func remove(timer: TogglTimer) {
        saved.removeAll {$0.id == timer.id}
        write()
    }
    
    func add(timer: TogglTimer) {
        saved.append(timer)
        write()
    }
    
    func index(of timer: TogglTimer) -> Int? {
        return saved.firstIndex(where: {[timer] in $0.id == timer.id})
    }
    
 
    func addNew() {
        saved.append(TogglTimer(id: UUID().hashValue, duration: -1362470338, created_with: "Timer2"))
        write()
    }
    
    init() {
        read()
    }
    
    
    func move (from source: IndexSet, to destination: Int) {
        saved.move(fromOffsets: source, toOffset: destination)
        write()

    }
    
    func remove (at offsets: IndexSet) {
        saved.remove(atOffsets: offsets)
        write()

    }
    
    
    func write() {
        do {
            let json = try JSONEncoder().encode(saved)
            let url = cloudData.directoryURL.appendingPathComponent ("SavedTimers.json")
            do {
                try json.write (to:url)
            } catch let error{
                print ("couldn't save \(error)")
            }
        }
        catch {
            print(error)
        }
    }
    
    
    
    func read() {
        let url = cloudData.directoryURL.appendingPathComponent ("SavedTimers.json")

        if let jsonData = try? Data(contentsOf:url){
            if let savedTimers = try? JSONDecoder().decode([TogglTimer].self, from: jsonData) {
                saved = savedTimers
            }
        }
    }
    
    func clear() {
        saved = []
        write()
    }
}
