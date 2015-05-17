class RepositoriesController < ApplicationController

  def index
    @username = params[:username]
    Dir.chdir("#{ENV['GIT_DIR']}/#{@username}")
    @repositories = Dir.glob('*').select {|f| (File.directory? f ) && (File.extname(f) == ".git")}
    @repositories.map! { |f| File.basename(f, ".git") }
  end

  def create
    username = params[:username]
    repository = params[:repository]
    print Rails.application.secrets
    path = "#{ENV['GIT_DIR']}/#{username}/#{repository}.git"
    if not File.directory?(path)
      Dir.mkdir path
      Rugged::Repository.init_at(path, :bare)
    end
  end

  def show
    @username = params[:username]
    @repository = params[:repository]
    @repo = Rugged::Repository.new("#{ENV['GIT_DIR']}/#{@username}/#{@repository}.git")
    @commit = @repo.references["refs/heads/master"].target
    @root = @commit.tree
  end

end
