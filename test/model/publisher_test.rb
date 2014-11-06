require 'test_helper'

describe ThemeRenderer::Publisher do

  describe '#call with defined repo' do
    let(:repo_uri) { URI.parse("file://#{File.expand_path('../..', __FILE__)}/test_repo") }
    let(:theme) { ThemeRenderer::Theme.new('Theme', repo_uri) }
    subject { ThemeRenderer::Publisher.new(theme) }

    it 'must pass' do
      subject.call.must_equal nil
    end
  end

  describe '#call without defined repo' do
    let(:theme) { ThemeRenderer::Theme.new('Theme') }
    subject { ThemeRenderer::Publisher.new(theme) }

    it 'shall not pass' do
      subject.call.must_equal false
    end
  end
end
