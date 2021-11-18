//
//  ContentView.swift
//  Shared
//
//  Created by Minna Yu on 11/9/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 1
    @State private var isShapeVisible: Bool = true
    let colors = Gradient(colors: [Color.yellow, Color.orange, Color.green, Color.purple, Color.blue, Color.orange])
    var body: some View {

        let tap = TapGesture(count: 2)
            .onEnded{_ in
                isShapeVisible = false
                print("Shape gone!")
            }
        TabView(selection: $selection){
            VStack {
                Toggle(isOn:$isShapeVisible.animation( .linear(duration: 2))) {
                Text("Show/Hide Shape")
                }.padding()
                if isShapeVisible {
                    Circle()
                        .fill(RadialGradient(gradient: colors, center: .center, startRadius: CGFloat(5), endRadius: CGFloat(250)))
                        .frame(width: 360, height: 350)
                        
                    .transition(.move(edge: .top))
                    } // end if
                }
            .contentShape(Rectangle())
            .gesture(tap)
            .tabItem{
                Image(systemName: "1.circle")
                Text("Screen One")
            }.tag(1)
            VStack {
                Toggle(isOn:$isShapeVisible.animation( .linear(duration: 2))) {
                Text("Show/Hide Shape")
                }.padding()
                if isShapeVisible {
                    Rectangle()
                        
                        .fill(LinearGradient(gradient: colors, startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 360, height: 350)
                        .transition (.slide)
                    }
                   
                }
            .contentShape(Rectangle())
            .gesture(tap)
            .tabItem{
                Image(systemName: "2.circle")
                Text("Screen Two")
            }.tag(2)
            VStack {
                Toggle(isOn:$isShapeVisible.animation( .linear(duration: 2))) {
                Text("Show/Hide Shape")
                }.padding()
                if isShapeVisible {
                    MyShape()
                        .fill(RadialGradient(gradient: colors, center: .bottom, startRadius: CGFloat(0), endRadius: CGFloat(500)))
                        
                        .transition(.opacity)
                }
            }
            .tabItem{
                Image(systemName: "3.circle")
                Text("Screen Three")
            }.tag(3)
            .contentShape(Rectangle())
            .gesture(tap)

        }
        
    }
}
struct MyShape: Shape {
    
    func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY), control: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
        
    }
}

struct RectangleShape: Shape{
    func path(in rect: CGRect) -> Path{
        return Path(rect)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
