// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "TinyIOSExample",
    platforms: [.iOS(.v14)],
    products: [
        .executable(name: "TinyExample", targets: ["TinyExample"]),
    ],
    targets: [
        .target(
            name: "CTiny",
            publicHeadersPath: "include",
            cSettings: [],
            linkerSettings: [.linkedLibrary("tiny_ios")]
        ),
        .executableTarget(
            name: "TinyExample",
            dependencies: ["CTiny"],
            path: "Sources/TinyExample"
        )
    ]
)
