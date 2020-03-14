//
//  ContentView.swift
//  ActivityIndicator
//
//  Created by Pavel Vaitsikhouski on 3/14/20.
//  Copyright © 2020 Pavel Vaitsikhouski. All rights reserved.
//

import SwiftUI

struct CustomActivityIndicatorShape: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    let distance = rect.width / 5
    let lineWidth: CGFloat = 10
    let cornerRadius = lineWidth / 2
    let firstPoint = CGPoint(x: cornerRadius, y: rect.height / 2)
    let secondPoint = CGPoint(x: distance, y: firstPoint.y)
    let thirdPoint = CGPoint(x: distance * 2, y: rect.height - cornerRadius)
    let fourthPoint = CGPoint(x: distance * 3, y: cornerRadius)
    let fifthPoint = CGPoint(x: distance * 4, y: firstPoint.y)
    let sixthPoint = CGPoint(x: distance * 5 - cornerRadius, y: firstPoint.y)
    
    path.move(to: firstPoint)
    path.addLine(to: secondPoint)
    path.move(to: secondPoint)
    path.addLine(to: thirdPoint)
    path.move(to: thirdPoint)
    path.addLine(to: fourthPoint)
    path.move(to: fourthPoint)
    path.addLine(to: fifthPoint)
    path.move(to: fifthPoint)
    path.addLine(to: sixthPoint)
    
    return path
      .strokedPath(StrokeStyle(lineWidth: lineWidth, lineCap: .round))
  }
}

struct ContentView: View {
  var body: some View {
    Rectangle()
      .fill(Color.activityIndicatorBackgroundColor)
      .frame(width: 100, height: 85, alignment: .center)
      .clipShape(CustomActivityIndicatorShape())
  }
}

extension Color {
  static var activityIndicatorBackgroundColor: Color {
    return .init(red: 180 / 255.0,
                 green: 220 / 255.0,
                 blue: 210 / 255.0)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
