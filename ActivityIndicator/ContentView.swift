//
//  ContentView.swift
//  ActivityIndicator
//
//  Created by Pavel Vaitsikhouski on 3/14/20.
//  Copyright © 2020 Pavel Vaitsikhouski. All rights reserved.
//

import SwiftUI

struct ProgressBarShape: Shape {
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

struct ProgressBar: View {
  @State private var xOffset: CGFloat = 0
  let width: CGFloat
  let duration: Double
  let backgroundColor: Color
  let color: Color
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Rectangle()
          .fill(self.backgroundColor)
          .clipShape(ProgressBarShape())
        Rectangle()
          .fill(self.color)
          .clipShape(ProgressBarShape())
          .mask(Rectangle()
            .path(in: .init(x: -self.width, y: 0,
                            width: self.width,
                            height: geometry.size.height))
            .offset(x: self.xOffset))
      }
      .animation(Animation.linear(duration: self.duration).repeatForever(autoreverses: false))
      .onAppear {
        self.animate(width: geometry.size.width)
      }
    }
  }
  
  func animate(width: CGFloat) {
    xOffset = width + self.width
  }
}

struct ContentView: View {
  var body: some View {
    ProgressBar(width: 25, duration: 1,
                backgroundColor: .background, color: .slider)
      .frame(width: 100, height: 80, alignment: .center)
  }
}

extension Color {
  static var background: Color {
    return .init(red: 180 / 255.0,
                 green: 220 / 255.0,
                 blue: 210 / 255.0)
  }
  static var slider: Color {
    return .init(red: 129 / 255.0,
                 green: 209 / 255.0,
                 blue: 183 / 255.0)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
