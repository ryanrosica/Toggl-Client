//
//  Timer2
//
//  Created by Ryan Rosica on 4/30/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation
import SwiftUI
struct TogglTimer: TogglObject, Identifiable, TimeBlock {
    func dataWrapper() -> Any.Type {
        return TogglTimerData.self
    }
    
    var id: Int = UUID().hashValue
    var project: TogglProject?
    var description: String? = nil
    var duration: Int?
    var created_with: String?
    var tags: [String]?
    var start: Date? {
        didSet {
            updateDuration()
        }
    }
    var name: String {
        project?.name ?? "No Project"
    }
    
    var stop: Date? {
        didSet {
            updateDuration()
        }
    }
    
    var color: Color {
        return project?.color() ?? .gray
    }
    var templateIdentifier: String {
        let projectString: String = String(project?.id ?? 0)
        let descriptionString: String = description ?? ""
        let tagsString = tags?.joined() ?? ""
        return " \(projectString) \(descriptionString) \(tagsString) "
    }
    
    var searchableData: String {
        let projectString: String = String(project?.name ?? "No Project")
        let descriptionString: String = description ?? ""
        let tagsString = tags?.joined() ?? ""
        return " \(projectString) \(descriptionString) \(tagsString) "
    }
    
    func hasTheSameTemplate(as otherTimer: TogglTimer) -> Bool {
        return ((otherTimer.project == project) && (otherTimer.description == description) && (otherTimer.tags == tags))
    }
    
    mutating func updateDuration() {
        let calendar = Calendar.current
        guard let start = start else { return }
        let dateComponents = calendar.dateComponents([Calendar.Component.second], from: start, to: stop ?? Date())
        let seconds = dateComponents.second
        self.duration = seconds
    }

    
    var currentTime: String {
        guard let start = start else { return "" }
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([Calendar.Component.second, Calendar.Component.minute, Calendar.Component.hour], from: start , to: stop ?? Date())
        let seconds = dateComponents.second
        let minutes = dateComponents.minute
        let hours = dateComponents.hour

        return String(format: "%01d:%02d:%02d", hours ?? 0, minutes ?? 0, seconds ?? 0)
    }
    
    func currentTime(from date: Date) -> String {
        guard let start = start else { return "" }
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([Calendar.Component.second, Calendar.Component.minute, Calendar.Component.hour], from: start , to: date)
        let seconds = dateComponents.second
        let minutes = dateComponents.minute
        let hours = dateComponents.hour

        return String(format: "%01d:%02d:%02d", hours ?? 0, minutes ?? 0, seconds ?? 0)
    }
}



extension TogglTimer {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case tags = "tags"
        case start = "start"
        case stop = "stop"
        case description = "description"
        case duration = "duration"
        case pid = "pid"
        case created_with = "created_with"
        case project = "project"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self)
        id = try values.decode(Int.self ,forKey: .id)
        description = try values.decodeIfPresent(String.self ,forKey: .description)
        tags = try values.decodeIfPresent([String].self ,forKey: .tags)
        let startIso8601 = try values.decodeIfPresent(String.self ,forKey: .start)
        let stopIso8601 = try values.decodeIfPresent(String.self ,forKey: .stop)

        let iSO8601DateFormatter = ISO8601DateFormatter()
        iSO8601DateFormatter.timeZone = .autoupdatingCurrent
        start = iSO8601DateFormatter.date(from: startIso8601 ?? "")
        stop = iSO8601DateFormatter.date(from: stopIso8601 ?? "")
        
        if let project = try? values.decodeIfPresent(TogglProject.self, forKey: .project) {
            self.project = project
        }
        
        else {
            if let pid = try values.decodeIfPresent(Int.self,forKey: .pid) {
                let userStore = UserStore.shared
                project = userStore.user?.projects?.first { pid == $0.id } ?? TogglProject(id: pid)


            }
        }
        duration = try values.decodeIfPresent(Int.self ,forKey: .duration)

    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        if let pid = project?.id {
            try container.encode(pid, forKey: .pid)
        }
        try container.encode(description, forKey: .description)
        try container.encode("Timer3", forKey: .created_with)
        try container.encode(tags, forKey: .tags)
        
        let iSO8601DateFormatter = ISO8601DateFormatter()
        iSO8601DateFormatter.timeZone = .autoupdatingCurrent
        if let start = start {
            let startIso8601 = iSO8601DateFormatter.string(from: start)
            try container.encode(startIso8601, forKey: .start)
        }
        if let stop = stop {
            let stopIso8601 = iSO8601DateFormatter.string(from: stop)
            try container.encode(stopIso8601, forKey: .stop)
        }
        
        try container.encode(project, forKey: .project)
        try container.encode(duration, forKey: .duration)

    }
}


