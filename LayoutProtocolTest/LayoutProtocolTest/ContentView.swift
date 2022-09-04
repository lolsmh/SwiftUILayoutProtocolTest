//
//  ContentView.swift
//  LayoutProtocolTest
//
//  Created by Daniil on 31/7/22.
//

import SwiftUI
import CoreMotion


struct ContentView: View {
	
	@State
	private var layoutKind: LayoutKind = .vertical

	// Рабочий вариант на момент Xcode 14 beta 6
	// Меняется из беты в бету
	private var layout: any Layout {
		switch layoutKind {
		case .vertical:
			return VStackLayout()
		case .horizontal:
			return HStackLayout()
		case .z:
			return ZStackLayout()
		case .grid:
			return GridLayout()
		case .circle:
			return CircleLayout(radius: 100)
		}
	}

	private var nextLayout: LayoutKind {
		LayoutKind(rawValue: (layoutKind.rawValue + 1) % LayoutKind.allCases.count) ?? .vertical
	}
	
	private let emojis = ["🔥", "🥳", "🐲", "🎁", "🫀", "🐭"]
	
	var body: some View {
		
		let anyLayout = AnyLayout(layout)
		
		VStack {
			
			Spacer()
			
			anyLayout {
				ForEach(emojis.chunked(into: 3), id: \.self) { emojiArray in
					GridRow {
						ForEach(emojiArray, id: \.self) { emoji in
							EmojiView(emoji: emoji)
						}
					}
				}
			}
			.padding()
			
			Spacer()
			
			Button {
				withAnimation(.spring()) {
					layoutKind = nextLayout
				}
			} label: {
				Text("Change Layout")
			}
			.buttonStyle(.borderedProminent)

		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.cyan)
    }
}

// MARK: - LayoutKind
extension ContentView {
	enum LayoutKind: Int, CaseIterable {
		case vertical
		case horizontal
		case z
		case grid
		case circle
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
