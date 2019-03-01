//
//  CommonProtocol.swift
//  companion
//
//  Created by Sergiy SHILINGOV on 11/7/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import Foundation

enum SectionType {
    case main
    case skills
    case projects
}

protocol SectionProtocol {
    var type: SectionType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}
