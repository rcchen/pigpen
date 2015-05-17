class TreesController < ApplicationController

  def show
    @username = params[:username]
    @repository = params[:repository]
    @branch = params[:branch]
    @path = params[:path]
    path_components = @path.nil? ? Array.new : @path.split("/")
    @repo = Rugged::Repository.new("/opt/git/#{@username}/#{@repository}.git")
    @base_path = "/#{@username}/#{@repository}"
    @root = @repo.branches["origin/#{@branch}"].target.tree
    num_components = path_components.count
    while (path_components.count > 0)
      @root.each_tree do |e|
        if e[:name] == path_components[0]
          @root = @repo.lookup(e[:oid])
          path_components.shift
          break
        end
      end
      if (num_components == path_components.count)
        break
      end
    end
  end

end
