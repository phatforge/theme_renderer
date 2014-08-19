require 'test_helper'

describe ThemeRenderer::Config do

  describe 'ClassMethods' do

    subject { TR::Config }

    describe '::new' do
      before(:each) do
        @config = subject.new
      end

      it 'has a default value for "theme_id"' do
        @config.theme_id.wont_be_nil
      end

      it 'has a default value for "theme.stores"' do
        @config.theme.stores.wont_be_nil
      end
    end

    describe '::validate!' do
      it 'raises InvalidConfig error if the given config is invalid' do
        invalid_config = MiniTest::Mock.new
        invalid_config.expect(:valid?, false)
        invalid_config.expect(:errors, [])

        proc { subject.validate!(invalid_config) }.must_raise TR::InvalidConfig
        assert invalid_config.verify
      end
    end
  end

  it 'should be valid by default' do
    config = ThemeRenderer::Config.new
    config.valid?.must_equal true
    config.theme.stores.must_include 'TR::ThemeStorage::File'
  end
end
