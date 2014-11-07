require 'test_helper'

describe ThemeRenderer::Source::Git do

  let(:path) { "file://#{File.expand_path('../../..', __FILE__)}/test_repo" }
  let(:repo_uri) { URI.parse(path) }

  subject { ThemeRenderer::Source::Git.new(repo_uri.path) }

  describe '#walk' do
    before do
      # make git repo at above uri
    end

    it 'must pass' do
      subject.walk { |_a, _b, _c| }.must_equal nil
    end

  end
end
