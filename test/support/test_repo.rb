
#
# Create a test repo
#

require 'rugged'
require 'pathname'
require 'fileutils'

def create_git_repo(path='test/', name='test_repo2')
  repo_path = Pathname.new(File.expand_path(name, path))
  # FileUtils.remove_dir(repo_path)
  repo = Rugged::Repository.init_at(repo_path.to_s)

  file_path = 'README.md'
  content = 'Test repo Readme'
  commit_file(repo, file_path, content)
  repo
end

def commit_file(repo, file_path='random_file', content='bump data for commit')
  oid = repo.write(content, :blob)
  index = repo.index
  # index.read_tree(repo.head.target.tree)
  index.add(:path => file_path, :oid => oid, :mode => 0100644)

  options = {}
  options[:tree] = index.write_tree(repo)

  options[:author] = { :email => "testuser@github.com", :name => 'Test Author', :time => Time.now }
  options[:committer] = { :email => "testuser@github.com", :name => 'Test Author', :time => Time.now }
  options[:message] ||= "Making a commit via Rugged!"
  options[:parents] = repo.empty? ? [] : [ repo.head.target ].compact
  options[:update_ref] = 'HEAD'

  sha = Rugged::Commit.create(repo, options)
  repo.create_branch("master") unless repo.branches.exists?('master')
  sha
end
