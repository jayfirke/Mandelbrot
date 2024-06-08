//
//  MandelbrotView.swift
//  Mandelbrot
//
//  Created by Jay Firke on 07/06/24.
//

import SwiftUI

struct MandelbrotView: View {
    @State private var zoom: CGFloat = 1.0
    @State private var panOffset: CGSize = .zero
    @State var colors: [Color] = []
    @State var reversed: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            Canvas { context, size in
                drawMandelbrot(in: context, size: size)
            }
            .gesture(DragGesture()
                .onChanged { value in
                    panOffset = value.translation
                }
                .onEnded { value in
                    panOffset = .zero
                }
            )
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        zoom = value.magnitude
                    }
                    .onEnded { value in
                        zoom = value.magnitude
                    }
            )
            .frame(width: geometry.size.width, height: geometry.size.height)
            .scaleEffect(zoom)
            .offset(panOffset)
        }
        .overlay(VStack {
            Slider(value: $zoom, in: 0.5...10, step: 0.1) {
                Text("Zoom Mandelbrot")
                    .foregroundStyle(.white)
            }
            .padding()
            Spacer()
            Button(action: {
                reversed.toggle()
            }) {
                Text("Reverse Direction")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        })
        .onAppear {
            generateRandomColors()
        }
    }
}

#Preview {
    MandelbrotView()
}
