module Planner
  class TasksController < BaseController
    before_action :set_event
    before_action :set_task, only: [:edit, :update, :destroy]

    def index
      @tasks = @event.tasks.ordered.includes(:assigned_to)
      @pending_tasks = @tasks.pending
      @in_progress_tasks = @tasks.in_progress
      @completed_tasks = @tasks.completed
    end

    def new
      @task = @event.tasks.build
    end

    def create
      @task = @event.tasks.build(task_params)
      @task.created_by = current_user

      if @task.save
        redirect_to planner_event_tasks_path(@event), notice: "Task created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @task.update(task_params)
        redirect_to planner_event_tasks_path(@event), notice: "Task updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @task.destroy
      redirect_to planner_event_tasks_path(@event), notice: "Task deleted."
    end

    private

    def set_event
      @event = Event.friendly.find(params[:event_id])
    end

    def set_task
      @task = @event.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :description, :due_date, :status, :priority, :assigned_to_id, :position)
    end
  end
end
