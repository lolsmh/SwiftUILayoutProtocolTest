//
//  CircleLayout.swift
//  LayoutProtocolTest
//
//  Created by Daniil on 4/9/22.
//

import SwiftUI

struct CircleLayout: Layout {
	
	// MARK: - Internal Properties
	let radius: CGFloat
	
	// MARK: - Internal Methods
	func sizeThatFits(
		proposal: ProposedViewSize,
		subviews: Subviews,
		cache: inout ()
	) -> CGSize {
		let maxSize = getMaxSize(for: subviews)
		
		let verticalSpacing = getSpacing(
			for: subviews,
			along: .vertical
		)
			.reduce(into: .zero, { $0 += $1 })
		
		let horizontalSpacing = getSpacing(
			for: subviews,
			along: .horizontal
		)
			.reduce(into: .zero, { $0 += $1 })
		
		return CGSize(
			width: radius * 2 + maxSize.width + horizontalSpacing / 2,
			height: radius * 2 + maxSize.height + verticalSpacing / 2
		)
	}
	
	func placeSubviews(
		in bounds: CGRect,
		proposal: ProposedViewSize,
		subviews: Subviews,
		cache: inout ()
	) {
		let maxSize = getMaxSize(for: subviews)
		let proposal = ProposedViewSize(maxSize)
		
		let verticalSpacing = getSpacing(
			for: subviews,
			along: .vertical
		)
			.reduce(into: .zero, { $0 += $1 })
		
		let horizontalSpacing = getSpacing(
			for: subviews,
			along: .horizontal
		)
			.reduce(into: .zero, { $0 += $1 })
		
		for (index, subview) in subviews.enumerated() {
			let center = CGPoint(x: bounds.midX - horizontalSpacing / 2, y: bounds.midY - verticalSpacing / 2)
			let origin = getPosition(
				forSubviewIndex: index,
				radius: radius,
				center: center,
				subviewsCount: subviews.count
			)
			subview.place(at: origin, proposal: proposal)
		}
	}
	
	// MARK: - Private Methods
	private func getPosition(
		forSubviewIndex index: Int,
		radius: CGFloat,
		center: CGPoint,
		subviewsCount: Int
	) -> CGPoint {
		let theta = (CGFloat.pi * 2 / CGFloat(subviewsCount)) * CGFloat(index)
		return CGPoint(
			x: center.x + radius * cos(theta),
			y: center.y + radius * sin(theta)
		)
	}
	
	private func getMaxSize(for subviews: Subviews) -> CGSize {
		subviews.reduce(.zero) { currentMaxSize, subview in
			let currentSize = subview.sizeThatFits(.unspecified)
			return CGSize(
				width: max(currentSize.width, currentMaxSize.width),
				height: max(currentSize.height, currentMaxSize.height)
			)
		}
	}
	
	private func getSpacing(for subviews: Subviews, along axis: Axis) -> [CGFloat] {
		subviews.indices.map { index -> CGFloat in
			guard index < subviews.count else {
				return 0
			}
			
			return subviews[index].spacing.distance(
				to: subviews[index].spacing,
				along: axis
			)
		}
	}
}
