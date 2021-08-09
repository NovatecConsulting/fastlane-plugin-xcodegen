describe Fastlane do
  describe Fastlane::FastFile do
    describe "XcodeGen Integration" do
      it "returns shell output" do
        expect(Fastlane::Actions).to receive(:sh).with("which xcodegen", anything)
        expect(Fastlane::Actions).to receive(:sh).with("xcodegen").and_return("Shell Output")

        result = Fastlane::FastFile.new.parse("lane :test do
          xcodegen
        end").runner.execute(:test)

        expect(result).to eq("Shell Output")
      end
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
    end
  end
end
