class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :show, :update, :destroy]
  
  def index
    @tasks = Task.all
  end

  def edit
  end

  def new
    @task = Task.new
  end

  def show
  end
  
  def create
    @task = Task.new(params_task)
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
end

private

def set_task
  @task = Task.find(params[:id])
end

def params_task
  params.require(:task).permit(:content)
end