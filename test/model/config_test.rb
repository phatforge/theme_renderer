require 'test_helper'

describe ThemeRenderer::Config do

  describe "ClassMethods" do

    subject { TR::Config}

    describe "::new" do
      before(:each) do
        @config = subject.new
      end

      it "has a default value for 'theme.storage'" do
        @config.theme.storage.wont_be_nil
      end
    end

    describe "::validate!" do
      it "raises InvalidConfig error if the given config is invalid" do
        invalid_config = MiniTest::Mock.new
        invalid_config.expect(:valid?, false)
        invalid_config.expect(:errors, [])

        subject.validate!(invalid_config).must_raise(TR::InvalidConfig)
        assert invalid_config.verify
      end
    end

  end

  it 'should be valid by default' do
    config = ThemeRenderer::Config.new
    config.valid?.must_equal true
    config.storage.must_equal ::ThemeRenderer::Storage::File
  end
end
