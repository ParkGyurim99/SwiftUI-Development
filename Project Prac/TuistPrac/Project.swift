import ProjectDescription
import ProjectDescriptionHelpers
// import MyPlugin

/*
                +-------------+
                |             |
                |     App     | Contains TuistPrac App target and TuistPrac unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

// Local plugin loaded
// let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
// let project = Project.app(name: "TuistPrac",
//                           platform: .iOS,
//                           additionalTargets: ["TuistPracKit", "TuistPracUI", "MyModule"])


let project = Project(
    name: "TuistPrac",
    packages: [
        .remote(
            url: "https://github.com/Alamofire/Alamofire",
            requirement: .upToNextMajor(from: "5.0.0")
        )
    ],
    targets: [
        Target(
            name: "TuistPrac",
            platform: .iOS,
            product: .app,
            bundleId: "dev.parkgyurim.TuistPrac",
            sources: [ "Targets/TuistPrac/**" ],
            dependencies: [
                .target(name: "TuistPracUI"),
                .target(name: "MyModule")
            ]
        ),
//        Target(
//            name: "TuistPracKit",
//            platform: .iOS,
//            product: .framework,
//            bundleId: "dev.parkgyurim.TuistPracKit"
//        ),
        Target(
            name: "TuistPracUI",
            platform: .iOS,
            product: .framework,
            bundleId: "dev.parkgyurim.TuistPracUI",
            sources: [ "Targets/TuistPracUI/**" ]
        ),
        Target(
            name: "MyModule",
            platform: .iOS,
            product: .framework,
            bundleId: "dev.parkgyurim.TuistPracMyModule",
            sources: [ "Targets/MyModule/Sources/**" ],
            dependencies: [
                .package(product: "Alamofire"),
                .external(name: "Kingfisher"),
                .project(
                    target: "AdvancedScrollView",
                    path: "../AdvancedScrollViewWithTuist"
                )
            ]
        ),
        Target(
            name: "MyModuleTest",
            platform: .iOS,
            product: .unitTests,
            bundleId: "dev.parkgyurim.TuistPracMyModuleTest",
            sources: [ "Targets/MyModule/Tests/**" ],
            dependencies: [ .target(name: "MyModule") ]
        )
    ]
)

