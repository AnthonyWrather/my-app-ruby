require 'net/http'
require 'uri'
require 'json'
class PagesController < ApplicationController
  before_action :set_user_data, only: %i[signup login]
  before_action :authenticate_user, except: %i[signup login index]
  before_action :get_todos_service, only: %i[home create_todo]
  before_action :get_myfiles_service, only: %i[home create_todo]
  before_action :get_myfolders_service, only: %i[home create_todo]
  def index; end

  def signup
    uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=#{Rails.application.credentials.google.firebase_api_key}")

    response = Net::HTTP.post_form(uri, "email": @email, "password": @password)
    data = JSON.parse(response.body)
    session[:user_id] = data['localId']
    session[:data] = data
    # self.current_user = data['localId']

    redirect_to home_path, notice: 'Signed up successfully!' if response.is_a?(Net::HTTPSuccess)
  end

  def home
    @todos = @todos_service.all
    @myfiles = @myfiles_service.all
    @myfolders = @myfolders_service.all
  end

  def login
    uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=#{Rails.application.credentials.google.firebase_api_key}")

    response = Net::HTTP.post_form(uri, "email": @email, "password": @password)
    data = JSON.parse(response.body)

    if response.is_a?(Net::HTTPSuccess)
      session[:user_id] = data['localId']
      session[:data] = data
      redirect_to home_path, notice: 'Logged in successfully!'
    end
  end

  def logout
    session.clear
    redirect_to root_path, notice: 'Logged out successfully!'
  end

  def photoalbum
    # @myfiles = @myfiles_service.all
  end

  def create_todo
    Todo.new.save(params[:title], session) if params[:title].present?
    redirect_to home_path, notice: 'Todo created successfully!'
  end

  private

  def get_todos_service
    @todos_service = Todos.new(current_user)
  end

  def get_myfiles_service
    @myfiles_service = MyFiles.new(current_user)
  end

  def get_myfolders_service
    @myfolders_service = MyFolders.new(current_user)
  end

  def set_user_data
    @email = params[:email]
    @password = params[:password]
  end

  def authenticate_user
    redirect_to root_path, notice: 'You must be logged in to view this page!' unless current_user
  end
end
