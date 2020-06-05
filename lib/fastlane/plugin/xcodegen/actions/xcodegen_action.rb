require 'fastlane/action'
require_relative '../helper/xcodegen_helper'

module Fastlane
  module Actions
    class XcodegenAction < Action
      def self.run(params)
        require 'fastlane/plugin/brew'

        Actions.sh("which xcodegen", log: false, error_callback: proc do |error_output|
          UI.message("Installing XcodeGen")

          Actions::BrewAction.run(command: "tap yonaskolb/XcodeGen https://github.com/yonaskolb/XcodeGen.git")
          Actions::BrewAction.run(command: "install XcodeGen")
        end)

        cmd = ["xcodegen"]
        cmd << "--spec #{params[:spec]}" if params[:spec]
        cmd << "--project #{params[:project]}" if params[:project]
        cmd << "--quiet" if params[:quiet]
        cmd << "--use-cache" if params[:use_cache]
        cmd << "--cache-path #{params[:cache_path]}" if params[:cache_path]
        cmd << "--project-root #{params[:project_root]}" if params[:project_root]

        Actions.sh(cmd.join(' '))
      end

      def self.description
        "Runs `xcodegen` for the project"
      end

      def self.authors
        ["Michael Ruhl"]
      end

      def self.details
        [
          "Will be installed with `brew` if not available",
          "Runs `xcodegen` for the project."
        ].join("\n")
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :spec,
                                       env_name: "XCODEGEN_SPEC",
                                       description: "The path to the project spec file",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :project,
                                      env_name: "XCODEGEN_PROJECT",
                                      description: "The path to the folder where the project should be generated",
                                      optional: true),
          FastlaneCore::ConfigItem.new(key: :quiet,
                                      env_name: "XCODEGEN_QUIET",
                                      description: "Whether to suppress informational and success messages",
                                      optional: true,
                                      is_string: false),
          FastlaneCore::ConfigItem.new(key: :use_cache,
                                      env_name: "XCODEGEN_USE_CACHE",
                                      description: "Used to prevent unnecessarily generating the project",
                                      optional: true,
                                      is_string: false),
          FastlaneCore::ConfigItem.new(key: :cache_path,
                                      env_name: "XCODEGEN_CACHE_PATH",
                                      description: "A custom path to use for your cache file",
                                      optional: true),
          FastlaneCore::ConfigItem.new(key: :project_root,
                                      env_name: "XCODEGEN_PROJECT_ROOT",
                                      description: "The path to the project root directory",
                                      optional: true)
        ]
      end

      def self.is_supported?(platform)
        platform == :ios
      end
    end
  end
end
