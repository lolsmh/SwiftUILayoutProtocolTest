//
//  EmojiView.swift
//  LayoutProtocolTest
//
//  Created by Daniil on 4/9/22.
//

import SwiftUI

struct EmojiView: View {
	let emoji: String
	
	var body: some View {
		Text(emoji)
			.font(.title3)
			.padding(.horizontal, 8)
			.padding(.vertical, 13)
			.background(.white)
			.cornerRadius(10)
			.shadow(radius: 5)
	}
}
