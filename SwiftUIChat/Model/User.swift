//
//  User.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/25/21.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Hashable, Decodable {
    @DocumentID var id: String?
    let username: String
    let email: String
    var profileImageUrl: String
    var fullname: String
    var status: UserStatus
    
    var isCurrentUser: Bool { return AuthViewModel.shared.userSession?.uid == id }
}

enum UserStatus: Int, CaseIterable, Codable {
    case notConfigured
    case available
    case busy
    case school
    case movies
    case work
    case batteryLow
    case meeting
    case gym
    case sleeping
    case urgentCallsOnly
    
    var description: String {
        switch self {
        case .notConfigured: return "Click here to update your status"
        case .available: return "Available"
        case .busy: return "Busy"
        case .school: return "At school"
        case .movies: return "At the movies"
        case .work: return "At work"
        case .batteryLow: return "Battery about to die"
        case .meeting: return "In a meeting"
        case .gym: return "At the gym"
        case .sleeping: return "Sleeping"
        case .urgentCallsOnly: return "Urgent calls only"
        }
    }
}
