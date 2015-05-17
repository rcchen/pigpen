Rails.application.routes.draw do
  post '/:username/repositories', to: 'repositories#create'
  get '/:username/:repository', to: 'repositories#show'
  get '/:username/:repository/trees', to: 'trees#index'
  get '/:username/:repository/trees/:branch', to: 'trees#show'
  get '/:username/:repository/trees/:branch/*path', to: 'trees#show'
  get '/:username/:repository/trees/:branch/*path/:file', to: 'blobs#show'
end
