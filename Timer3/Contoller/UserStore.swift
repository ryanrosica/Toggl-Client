//
//  UserStore.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/18/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation
import Combine

class UserStore: ViewModel {
    static let shared = UserStore()
    @Published private(set) var user: TogglUser?
    
    private override init() {
        super.init()
        refresh()
    }

    var addCancellable: AnyCancellable?
    func add(project: TogglProject) {
        addCancellable?.cancel()
        var project = project
        guard let wid = user?.workspaces?[0].id else { return }
        project.wid = wid
        let request = TogglRequest<TogglProjectData>(
            endpoint: .projects,
            httpMethod: .PUT,
            dataWrapper: TogglProjectData(data: project)
        )
        addCancellable = request.publisher?.sink(
            receiveCompletion: recieveCompletion,
            receiveValue: { _ in self.refresh() }
        )
    }

    
    var deleteCancellable: AnyCancellable?
    func delete(project: TogglProject) {
        deleteCancellable?.cancel()
        let pid = project.id
        user?.projects?.removeAll(where: { $0.id == pid })
        let request = TogglRequest<TogglProjectData>(
            endpoint: .project(pid),
            httpMethod: .DELETE
        )
        deleteCancellable = request.publisher?.sink(
            receiveCompletion: recieveCompletion,
            receiveValue: { _ in self.refresh() }
        )
    }

    func deleteProject(at index: Int) {
        guard let projects = user?.projects else { return }
        guard projects.indices.contains(index) else { return }
        delete(project: projects[index])
    }
    
    
    var refreshCancellable: AnyCancellable?
    func refresh(completion: ( () -> Void)? = nil) {
        refreshCancellable?.cancel()
        self.state = .loading
        let request = TogglRequest<TogglUserData>(
            endpoint: .user,
            httpMethod: .GET
        )
        refreshCancellable = request.publisher?.sink(
            receiveCompletion: recieveCompletion,
            receiveValue: { userData in
                guard var user = userData?.data else {
                    self.state = .error(.unknown)
                    return
                }
                let projectsFilteredByNonArchived = user.projects?.filter{ ($0.deleted) }
                user.projects = projectsFilteredByNonArchived
                self.user = user
                if let completion = completion { completion() }
            }
        )
    }
    
    
    var updateProjectCancellable: AnyCancellable?
    func updateProject(from project1: TogglProject, to project2: TogglProject) {
        updateProjectCancellable?.cancel()
        let request = TogglRequest<TogglProjectData> (
            endpoint: .project(project1.id),
            httpMethod: .PUT,
            dataWrapper: TogglProjectData(data: project2)
        )
        updateProjectCancellable = request.publisher?.sink(
            receiveCompletion: recieveCompletion,
            receiveValue: { _ in self.refresh() }
        )
    }
}

