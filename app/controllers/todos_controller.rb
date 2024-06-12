class TodosController < ApplicationController
  def index
    session[:todos] ||= []
    session[:completed_todos] ||= []
    render layout: false
  end

  # todosコントローラーのcreateアクション
  def create
    session[:todos] << params[:todo]
    index = session[:todos].index(params[:todo])
    respond_to do |format|
      format.html{ render turbo_stream: turbo_stream.append('todos', partial: 'todos/todo', locals: { todo: params[:todo], index: index}) }
      format.turbo_stream { redirect_to todos_path }
    end
  end

  def destroy
    session[:todos].delete_at(params[:id].to_i)
    redirect_to todos_path
  end

  def complete
    task = session[:todos].delete_at(params[:id].to_i)
    session[:completed_todos] << task
    redirect_to todos_path
  end

  def uncomplete
    task = session[:completed_todos].delete_at(params[:id].to_i)
    session[:todos] << task
    redirect_to todos_path
  end

  def destroy_completed
    session[:completed_todos].delete_at(params[:id].to_i)
    redirect_to todos_path
  end
end
