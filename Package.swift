// swift-tools-version:5.1
import PackageDescription

let package = Package(
	name: "AsyncProcess",
	products: [
		.library(
			name: "AsyncProcess",
			targets: ["AsyncProcess"]
		),
	],
	dependencies: [
		.package(url: "https://github.com/randymarsh77/async", .branch("master")),
		.package(url: "https://github.com/hkellaway/gloss", .exact("3.2.1")),
	],
	targets: [
		.target(
			name: "AsyncProcess",
			dependencies: ["Async", "Gloss"]
		),
	]
)
