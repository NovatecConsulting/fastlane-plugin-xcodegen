# xcodegen plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-xcodegen)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-xcodegen`, add it to your project by running:

```bash
fastlane add_plugin xcodegen
```

## About xcodegen

Generates the Xcode-Project as specified in the YAML or JSON format.
More Information on [_XcodeGen_](https://github.com/yonaskolb/XcodeGen)


## Example

```ruby
  xcodegen(
  	spec: "PATH/project.yml",
  	project: "PATH/Project.xcodeproj",
  	quiet: true,
  	use_cache: true,
  	cache_path: "~/.xcodegen/cache/MyProject",
  	project_root: "../"
  )
```

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
