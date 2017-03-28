import PackageDescription

let package = Package(
    name: "AsyncProcess",
    dependencies: [
		.Package(url: "https://github.com/randymarsh77/async", majorVersion: 1),
		.Package(url: "https://github.com/hkellaway/gloss", majorVersion: 1),
	]
)
