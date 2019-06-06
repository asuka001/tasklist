class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def edit
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def show
    @task = Task.find(params[:id])
  end
  
  def create
    @task = Task.new(pramas_task)
    if @task.save
      flash[:successs] = "正常に投稿されました"
      redirect_to @task
    else
      flash.now[:danger] = "投稿されませんでした"
      render :new
    end
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.update(params_task)
      flash[:success] = "正常に更新されました"
      redirect_to @task
    else
      flash[:danger] = "更新されませんでした"
      render :edit
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = "正常に削除されました"
    redirect_to tasks_url
  end
  
end

private

def params_task
  params.require(:task).permit(:content)
end