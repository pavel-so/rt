Rails.application.routes.draw do
  root 'traps#index'
  match '/:trap_name', to: 'traps#create', via: :all, as: 'create_trap'
  get "/:trap_name/requests" => "entries#index", as: "trap"
  get "/:trap_name/requests/:id" => "entries#show", as: "entry"
end
