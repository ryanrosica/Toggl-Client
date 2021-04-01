//
//  TogglController.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/18/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation

public class TogglController {
    static var shared = TogglController()
    
    
    private init() {}

    func successHaptic() {

    }
    
    func errorHaptic() {

    }
    
    func display(error: TogglError) {
        print(error)
        if error == .network {
            errorHaptic()
        }

    }
    
    func requestProject(pid: Int, completionHandler: @escaping (TogglProject?) -> Void) {
        print("Request Project")

        let request = TogglRequest<TogglProjectData>(endpoint: .project(pid), httpMethod: .GET)
        request.fetch {projectDataResponse in
            
            switch projectDataResponse {
                case .error(let error):
                    self.display(error: error)
                    completionHandler(nil)
                case .success(let projectData):
                    completionHandler(projectData.data)
            }

        }
    }
    
    func requestRunning(completionHandler: @escaping (TogglTimer?) -> Void) {
        print("Request Running")

        let request = TogglRequest<TogglTimerData>(endpoint: .currentTimeEntry, httpMethod: .GET)
        request.fetch { timerDataResponse in
            switch timerDataResponse {
                case .error(let error):
                    self.display(error: error)
                    completionHandler(nil)
                case .success(let timerData):
                    var timer = timerData.data
                    guard let pid = timerData.data.project?.id else {
                        completionHandler(timer)
                        return
                    }
                    self.requestProject(pid: pid) { project in
                        timer.project = project
                        completionHandler(timer)
                    }
            }
        }
    }
    
    func update(timer: TogglTimer, to newTimer: TogglTimer, completionHandler: @escaping () -> Void) {
        print("Request Update")

        
        do {
            let data = try JSONEncoder().encode(TogglTimerData(data: newTimer))
            let request = TogglRequest<TogglTimerData>(endpoint: .timeEntry(timer.id), httpMethod: .PUT, data: data)
            request.fetch{_ in
                completionHandler()
            }
        }
        catch {
            completionHandler()
            print(error)
        }

        
    }
    
    func updateRunning(timer: TogglTimer, completionHandler: @escaping () -> Void) {
        print("Update Running")

        
        requestRunning { runningTimer in
            guard let running = runningTimer else { return }
            
            self.update(timer: running, to: timer) {
                completionHandler()
            }
            
        }
    }
    
    func stopRunning(timer: TogglTimer, completionHandler: @escaping () -> Void) {
        print("Request Stop Running")

        let request = TogglRequest<TogglTimerData>(endpoint: .stopRunning(timer.id), httpMethod: .PUT)
        
        request.fetch { timer in
            completionHandler()
            self.successHaptic()
        }
    }
    
    func start(timer: TogglTimer, completionHandler: @escaping () -> Void) {
        print("Request Start")

        let timerData = TogglTimerData(data: timer)
        do {
            let data = try JSONEncoder().encode(timerData)
           
            let request = TogglRequest<TogglTimerData>(endpoint: .startTimer, httpMethod: .POST, data: data)
            request.fetch {_ in
                self.successHaptic()
                completionHandler()
            }
            
        }
        catch {
           print(error)
        }
    }
    
    
    func delete(timer: TogglTimer, completionHandler: @escaping () -> Void) {
        print("Request Delete")

        let id = timer.id
                
        let request = TogglRequest<TogglTimerData> (endpoint: .timeEntry(id), httpMethod: .DELETE)
        
        request.fetch { timerResponse in
            switch timerResponse {
                case .error(let error):
                    self.display(error: error)
                    completionHandler()
                case .success(_):
                    completionHandler()
            }
            
            completionHandler()
        }
        
    }
    
    var user: TogglUser?
    
    func requestUser(completionHandler: @escaping (TogglUser?) -> Void) {
        guard user == nil else {
            completionHandler(user)
            return
        }
        print("Request User")
        let request = TogglRequest<TogglUserData>(endpoint: .user, httpMethod: .GET)
        request.fetch {userDataResponse in
            switch userDataResponse {
                case .error(let error):
                    self.display(error: error)
                    completionHandler(nil)
                case .success(let userData):
                    completionHandler(userData.data)
                    self.user = userData.data
            }
        }
    }
    
    func getTimeEntries(from startDate: Date, to endDate: Date, completionHandler: @escaping(([TogglTimer]?) -> Void)) {
        
        print("Request Get Time Entries")

        let iSO8601DateFormatter = ISO8601DateFormatter()
        iSO8601DateFormatter.timeZone = .autoupdatingCurrent
        
        let startISO8601 = iSO8601DateFormatter.string(from: startDate)
        let endISO8601 = iSO8601DateFormatter.string(from: endDate)
        
        let request = TogglRequest<[TogglTimer]>(endpoint: .timeEntries(startISO8601, endISO8601), httpMethod: .GET)
        
        request.fetch { entriesResponse in
            
            switch entriesResponse {
                case .error(let error):
                    self.display(error: error)
                    completionHandler(nil)
                case .success(let timeEntries):
                    self.requestUser { user in
                        guard let user = user else {
                            completionHandler(nil)
                            return
                        }
                        
                        var result = [TogglTimer]()
                        for timer in timeEntries {
                            var newTimer = timer
                            
                            if let pid = timer.project?.id {
                                let project = user.projects?.first(where: {$0.id == pid})
                                newTimer.project = project
                                result.append(newTimer)
                            }
                            else {
                                result.append(newTimer)
                            }
                        }

                        completionHandler(result)

                    }
            }
        }
    }
    
    func delete(project: TogglProject, completionHandler: @escaping (TogglProject?) -> Void) {
        print("Request Delete Project")

        let pid = project.id 
        
        let request = TogglRequest<TogglProject>(endpoint: .project(pid), httpMethod: .DELETE)
        
        request.fetch { projectResponse in
            switch projectResponse {
                case .error(let error):
                    self.display(error: error)
                    completionHandler(nil)
                case .success(let project):
                    completionHandler(project)
            }
        }
    }
    
    func updateProject(from project1: TogglProject, to project2: TogglProject, completionHandler: @escaping(TogglProject?) -> Void) {
        print("Request Update Project")
        
        let projectData = TogglProjectData(data: project2)
        let pid = project1.id 
        
        do {
            let projectJSON = try JSONEncoder().encode(projectData)
            let request = TogglRequest<TogglProjectData>(endpoint: .project(pid), httpMethod: .PUT, data: projectJSON)
            request.fetch { projectDataResponse in
                switch projectDataResponse {
                    case .error(let error):
                        print("put error")
                        self.display(error: error)
                        completionHandler(nil)
                    case .success(let projectData):
                        print("put success")

                        completionHandler(projectData.data)
                }
            }
        }
        catch {
            self.display(error: TogglError.invalid)
            completionHandler(nil)
        }
        
    }
    
    func newProject(project: TogglProject, completionHandler: @escaping (TogglProject?) -> Void) {
        print("Request New Project")

        let projectData = TogglProjectData(data: project)
        
        do {
            let projectJSON = try JSONEncoder().encode(projectData)
            let request = TogglRequest<TogglProjectData>(endpoint: .projects, httpMethod: .POST, data: projectJSON)
            request.fetch { projectDataResponse in
                
                switch projectDataResponse {
                    case .error(let error):
                        self.display(error: error)
                        completionHandler(nil)
                    case .success(let projectData):
                        completionHandler(projectData.data)
                }
            }
        }
        catch {
            self.display(error: TogglError.invalid)
            completionHandler(nil)
        }
        
    }

}

