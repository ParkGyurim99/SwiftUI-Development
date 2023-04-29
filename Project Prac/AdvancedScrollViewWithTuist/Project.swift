import ProjectDescription

let project = Project(
  name: "AdvancedScrollView",
  targets: [
    Target(
        name: "AdvancedScrollView",
        platform: .iOS,
        product: .framework,
        bundleId: "dev.parkgyurim.AdvancedScrollView",
        deploymentTarget: .iOS(targetVersion: "16.2", devices: [.iphone]),
        infoPlist: .default,
        sources: [ "AdvancedScrollView/**" ],
        resources: [ "AdvancedScrollView/Assets.xcassets/**" ]
    )
  ]
)
