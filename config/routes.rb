Rails.application.routes.draw do
  
  namespace :cms_admin, :path => LucyCms.config.admin_route_prefix, :except => :show do
    get '/' => redirect(LucyCms.config.admin_route_redirect)
    resources :pages do
      member do 
        match :form_blocks
        match :toggle_branch
      end
      collection do
        match :reorder
      end
    end
    resource :site do
      collection do
        get :setup
      end
    end
    resource :session
    resources :users do
      member do
        get  :change_password
        put :update_password
      end
    end
    resources :layouts
    resources :snippets
    resources :upload_dirs, :except => [:edit, :update] do
      collection do
        get :conflict
      end
      member do
        post :uploads
        post :uploads_destroy
      end
    end
  end
  
  scope :controller => :cms_content do
    get '/cms-css/:id'  => :render_css,   :as => 'cms_css'
    get '/cms-js/:id'   => :render_js,    :as => 'cms_js'
    get '/'             => :render_html,  :as => 'cms_html',  :path => '(*cms_path)'
  end
  
end
