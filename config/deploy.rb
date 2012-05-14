# RVM

set :using_rvm, true
#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
set :rvm_type, :system

require "rvm/capistrano"

# Bundler

#require "bundler/capistrano"

# General

set :application, "kursor"
set :user, "root"
#set :port, 3764

set :deploy_to, "/var/www/#{application}"
set :deploy_via, :copy

set :normalize_asset_timestamps, false

# Git

set :scm, :git
set :scm_verbose, true
set :repository,  "~/projects/#{application}/.git"
#set :repository,  "git@github.com:ivankukobko/Kursor-Online-catalog.git"
#set :branch, "master"

# VPS

role :web, "85.25.100.135"
role :app, "85.25.100.135"
role :db,  "85.25.100.135", :primary => true
role :db,  "85.25.100.135"

# Passenger

set :keep_releases, 4

namespace :deploy do
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "touch #{File.join(current_path,'tmp','restart.txt')}"
 end
end

# ==============================
# Uploads
# ==============================

namespace :uploads do

  desc <<-EOD
    Creates the upload folders unless they exist
    and sets the proper upload permissions.
  EOD
  task :setup, :except => { :no_release => true } do
    dirs = uploads_dirs.map { |d| File.join(shared_path, d) }
    run "#{try_sudo} mkdir -p #{dirs.join(' ')} && #{try_sudo} chmod g+w #{dirs.join(' ')}"
    #run "#{try_sudo} mkdir -p #{shared_path}/uploads"
    #run "#{try_sudo} mkdir -p #{shared_path}/uploads/avatar"
    #run "#{try_sudo} mkdir -p #{shared_path}/uploads/image"
    #run "#{try_sudo} mkdir -p #{shared_path}/uploads/provider"
    run "#{try_sudo} chmod 0777 -R #{shared_path}/uploads"
  end

  desc <<-EOD
    [internal] Creates the symlink to uploads shared folder
    for the most recently deployed version.
  EOD
  task :symlink, :except => { :no_release => true } do
    run "rm -rf #{release_path}/public/uploads"
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end

  desc <<-EOD
    [internal] Computes uploads directory paths
    and registers them in Capistrano environment.
  EOD
  task :register_dirs do
    #set :uploads_dirs,    %w(uploads uploads/tmp uploads/avatar uploads/image uploads/provider)
    set :uploads_dirs,    %w(uploads)
    set :shared_children, fetch(:shared_children) + fetch(:uploads_dirs)
  end

  after       "deploy:finalize_update", "uploads:symlink"
  on :start,  "uploads:register_dirs"

end

#after "deploy:symlink", "deploy:update_crontab"

#namespace :deploy do
  #desc "Update the crontab file"
  #task :update_crontab, :roles => :db do
    #run "cd #{release_path} && whenever --update-crontab #{application}"
  #end
#end
