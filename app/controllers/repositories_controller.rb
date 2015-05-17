class RepositoriesController < ApplicationController

  def create
    username = params[:username]
    repository = params[:repository]
    path = "/opt/git/#{username}/#{repository}.git"
    if not File.directory?(path)
      Dir.mkdir path
      Rugged::Repository.init_at(path, :bare)
    end
  end

  def show
    username = params[:username]
    repository = params[:repository]
    @repo = Rugged::Repository.new("/opt/git/#{username}/#{repository}.git")
    @root = repo.references["refs/heads/master"].target
  end

end
