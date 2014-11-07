
#
# Create a test repo
#

require 'rugged'
require 'pathname'
require 'fileutils'

def create_git_repo(path = 'test/', name = 'test_repo3')
  repo_path = Pathname.new(File.expand_path(name, path))
  # FileUtils.remove_dir(repo_path)
  repo = Rugged::Repository.init_at(repo_path.to_s)

  file_path = 'README.md'
  content = 'Test repo Readme'
  commit_file(repo, file_path, content)
  repo
end

def commit_file(repo, file_path = 'random_file', content = 'bump data commit')
  tree = stage_content(repo, content, file_path)

  sha = create_commit(repo, tree)

  repo.create_branch('master') unless repo.branches.exists?('master')
  sha
end

def create_commit(repo, tree)
  user = { email: 'testuser@github.com', name: 'Test Author', time: Time.now }
  options = {}
  options[:tree] = tree
  options[:author] = user
  options[:committer] = user
  options[:message] ||= 'Making a commit via Rugged!'
  options[:parents] = repo.empty? ? [] : [repo.head.target].compact
  options[:update_ref] = 'HEAD'
  Rugged::Commit.create(repo, options)
end

def stage_content(repo, content, file_path)
  oid = repo.write(content, :blob)
  index = repo.index
  index.add(path: file_path, oid: oid, mode: 0100644)
  index.write_tree(repo)
end
