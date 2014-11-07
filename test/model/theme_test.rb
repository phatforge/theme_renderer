# -*- encoding : utf-8 -*-
require 'test_helper'
require 'support/test_repo'

describe ThemeRenderer::Theme do
  subject { Theme }

  before do
    # repo = create_git_repo
  end

  let(:repo) { create_git_repo }
  let(:repo_uri) { URI.parse("git://#{repo.path}") }
  let(:repo_sha) { repo.branches['master'].target_id }

  describe '#new theme' do
    let(:theme) { ThemeRenderer::Theme.new('My Theme') }

    it 'must start with no version' do
      theme.version.must_equal nil
    end

    it 'must have a no version_number' do
      theme.version_number.must_equal nil
    end

    it 'must be named' do
      theme.name.must_equal 'My Theme'
    end
  end

  describe '#publishing a theme' do
    let(:theme) { ThemeRenderer::Theme.new('woot', repo_uri) }

    it 'must increment #version' do
      theme.publish!
      theme.version_number.must_equal 1
      theme.version_sha.wont_equal nil

      commit_file(repo)
      theme.publish!
      theme.version_number.must_equal 2
      theme.version_sha.must_equal repo_sha
    end
  end
end
