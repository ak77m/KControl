//
//  Modifiers.swift
//  KControl
//
//  Created by ak77m on 19.03.2022.
//

import SwiftUI

struct PressModifier: ViewModifier {
  @State private var isLongPressing = false
  let tapAction: (()->())
  let longPressAction: (()->())
  let mainColor: Color
  let borderColor = Color.gray
    
  func body(content: Content) -> some View {
    content
          .contentShape(RoundedRectangle(cornerRadius: 15, style: .circular))
          .background(isLongPressing ? Color.red : mainColor)
          
          .overlay(RoundedRectangle(cornerRadius: 15.0, style: .circular)
                    .stroke(borderColor, lineWidth: 4))
          .cornerRadius(15.0)
          .scaleEffect(isLongPressing ? 0.7 : 1.0)

      .onLongPressGesture(minimumDuration: 1.0, pressing: { (isPressing) in
        withAnimation {
          isLongPressing = isPressing
        }
      }, perform: {
        longPressAction()
      })
      
      .simultaneousGesture(
        TapGesture()
          .onEnded { _ in
            tapAction()
          }
      )
  }
}
