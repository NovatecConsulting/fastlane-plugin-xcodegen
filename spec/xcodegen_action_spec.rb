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
            xcodegen(project: '/tmp/Project.xcodeproj')
          end").runner.execute(:test)

        expect(result).to eq("xcodegen --project /tmp/Project.xcodeproj")
      end
    end
  end
end
