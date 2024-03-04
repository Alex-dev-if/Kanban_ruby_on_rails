class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
    @todo_tasks = Task.where(status: 'To Do')
    @doing_tasks = Task.where(status: 'Doing')
    @done_tasks = Task.where(status: 'Done')
    @quantidade_todo = @todo_tasks.count
    @quantidade_doing = @doing_tasks.count
    @quantidade_done = @done_tasks.count
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end
  puts "siiiii #{ENV["APP_RAILWAY_DATABASE_PASSWORD"]}"
  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task) }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task) }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /tasks/1/update_status/Done
  def update_status
    @task = Task.find(params[:id])

    new_status = params[:new_status] # Recuperar o novo status da URL

    if @task.update(status: new_status)
      redirect_to tasks_path
    else
      redirect_to tasks_path
    end

    
  end
  

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Contact was successfully destroyed."}
      format.json { head :no_content }
    end
  end

  private 
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :description, :status)
    end
end
