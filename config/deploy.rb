# RVM

set :using_rvm, true
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
#set :rvm_ruby_string, 'default'
#set :rvm_type, :user
set :rvm_type, :system

# Bundler

require "bundler/capistrano"

# General

set :application, "kursor"
set :user, "root"
set :port, 3764

set :deploy_to, "/var/www/rails_apps/#{application}"
#set :deploy_via, :copy
#set :deploy_via, :remote_cache
#set :use_sudo, false

set :normalize_asset_timestamps, false

# Git

set :scm, :git
set :scm_verbose, true
#set :repository,  "~/projects/#{application}/.git"
set :repository,  "git@github.com:ivankukobko/Kursor-Online-catalog.git"
#set :branch, "master"

# VPS

role :web, "91.223.223.87"
role :app, "91.223.223.87"
role :db,  "91.223.223.87", :primary => true
role :db,  "91.223.223.87"

# Passenger

set :keep_releases, 4

namespace :deploy do
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "touch #{File.join(current_path,'tmp','restart.txt')}"
 end
end