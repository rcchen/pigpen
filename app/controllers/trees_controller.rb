class TreesController < ApplicationController

  def show
    username = params[:username]
    repository = params[:repository]
    branch = params[:branch]
    path = params[:path].nil? ? Array.new : params[:path].split("/")
    @repo = Rugged::Repository.new("/opt/git/#{username}/#{repository}.git")
    @root = @repo.references["refs/heads/#{branch}"].target.tree
    while (path.count > 0)
      @root.each_tree do |e|
        if e[:name] == path[0]
          @root = @repo.lookup(e[:oid])
          path.shift
          break
        end
      end
    end
  end

end
