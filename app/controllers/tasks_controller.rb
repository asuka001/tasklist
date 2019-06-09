class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_task, only: [:edit, :show, :update, :destroy]
  before_action :correct_user, only: [:destroy, :show]
  
  def index
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
  end

  def edit
  end

  def new
      @task = current_user.tasks.build
  end

  def show
  end
  
  def create
    @task = current_user.tasks.build(params_task)
    if @task.save
      flash[:successs] = "正常に投稿されました"
      redirect_to @task
    else
      flash.now[:danger] = "投稿されませんでした"
      render :new
    end
  end
  
  def update
    if @task.update(params_task)
      flash[:success] = "正常に更新されました"
      redirect_to @task
    else
      flash[:danger] = "更新されませんでした"
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = "正常に削除されました"
    redirect_to tasks_url
  end
  
  private

  def set_task
    @task = Task.find(params[:id])
  end
  
  def params_task
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end

end

