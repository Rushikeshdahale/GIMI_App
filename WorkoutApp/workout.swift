//
//  workout.swift
//  WorkoutApp
//
//  Created by Rushikesh Dahale on 22/11/23.
//

import Foundation

struct Object{
    var total : String
    var session : [Session]
}
struct Session{
    var day : String
    var workout : String
    var title : String
    var Instruction : String
    var image : String
    var imageUrl: URL?
}
