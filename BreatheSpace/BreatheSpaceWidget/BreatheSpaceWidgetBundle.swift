//
//  BreatheSpaceWidgetBundle.swift
//  BreatheSpaceWidget
//
//  Created by Echo Lumaque on 1/30/25.
//

import WidgetKit
import SwiftUI

@main
struct BreatheSpaceWidgetBundle: WidgetBundle {
    var body: some Widget {
        BreatheSpaceWidget()
        BreatheSpaceWidgetControl()
        BreatheSpaceWidgetLiveActivity()
    }
}
