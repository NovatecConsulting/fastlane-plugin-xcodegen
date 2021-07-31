describe Fastlane do
  describe Fastlane::FastFile do
    describe "XcodeGen Integration" do
      it "sets no param" do
        result = Fastlane::FastFile.new.parse("lane :test do
            xcodegen()
          end").runner.execute(:test)

        expect(result).to eq("xcodegen")
      end
      it "sets the spec param" do
        result = Fastlane::FastFile.new.parse("lane :test do
            xcodegen(spec: '/tmp/project.yml')
          end").runner.execute(:test)

        expect(result).to eq("xcodegen --spec /tmp/project.yml")
      end
      it "sets the project param" do
        result = Fastlane::FastFile.new.parse("lane :test do
            xcodegen(project: '/tmp/My Project.xcodeproj')
          end").runner.execute(:test)

        expect(result).to eq('xcodegen --project /tmp/My\ Project.xcodeproj')
      end
      it "sets the quiet param" do
        result = Fastlane::FastFile.new.parse("lane :test do
            xcodegen(quiet: true)
          end").runner.execute(:test)

        expect(result).to eq("xcodegen --quiet")
      end
      it "sets the use-cache param" do
        result = Fastlane::FastFile.new.parse("lane :test do
            xcodegen(use_cache: true)
          end").runner.execute(:test)

        expect(result).to eq("xcodegen --use-cache")
      end
      it "sets the cache-path param" do
        result = Fastlane::FastFile.new.parse("lane :test do
            xcodegen(cache_path: '~/.xcodegen/cache/MyProject')
          end").runner.execute(:test)

        cache_path = File.expand_path("~/.xcodegen/cache/MyProject")
        expect(result).to eq("xcodegen --cache-path #{cache_path}")
      end
      it "sets the project-root param" do
        result = Fastlane::FastFile.new.parse("lane :test do
            xcodegen(project_root: '/tmp/project-root')
          end").runner.execute(:test)

        expect(result).to eq("xcodegen --project-root /tmp/project-root")
      end
      it "ignores the quiet and use-cache params if false" do
        result = Fastlane::FastFile.new.parse("lane :test do
            xcodegen(quiet: false, use_cache: false)
          end").runner.execute(:test)

        expect(result).to eq("xcodegen")
      end
      it "attempts to install `xcodegen` using BrewAction if it doesn't exist" do
        # Expect that `which xcodegen` will fail
        expect(Fastlane::Actions).to receive(:sh).with("which xcodegen", hash_including(error_callback: anything)) { |command, params|
          error_callback = params[:error_callback]
          error_callback.call('xcodegen not found')
        }

        # Expect that the BrewAction is invoked as expected
        expect(Fastlane::Actions::BrewAction).to receive(:run).twice

        # And that the original command is then run as expected
        expect(Fastlane::Actions).to receive(:sh).with("xcodegen")

        Fastlane::FastFile.new.parse("lane :test do
            xcodegen
          end").runner.execute(:test)
      end
      it "supports a custom executable" do
        expect(Fastlane::Actions).to_not receive(:sh).with("which xcodegen", anything)
        expect(Fastlane::Actions::BrewAction).to_not receive(:run)
        expect(Fastlane::Actions).to receive(:sh).with("./bin/xcodegen", "--quiet")

        Fastlane::FastFile.new.parse("lane :test do
          xcodegen(executable: './bin/xcodegen', quiet: true)
        end").runner.execute(:test)
      end
    end
  end
end
