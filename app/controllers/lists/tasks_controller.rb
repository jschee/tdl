class Lists::TasksController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_list, except: [:index, :show]
  before_action :set_task, except: [:new, :create]

  def new
    @task = Task.new
  end

  def create
    respond_to do |format|
      if @list.update(list_params)
        flash[:notice] = 'Saved'
        format.turbo_stream { render_flash }
        format.html { redirect_to list_path(@list) }
      else
        format.html { render :new, status: :unprocessable_entity,
                                   notice: 'Sorry, but your task was not created, please try again.'
        }
      end
    end
  end

  def edit
    @list = List.find(params[:list_id])
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(dom_id(@task), partial: 'lists/tasks/incomplete_task_item')
        end
        format.html { redirect_to list_path(@list) }
      else
        format.html { redirect_to list_path(@list), notice: 'Your task was not updated, please try again.' }
      end
    end
  end

  def destroy
    @task.destroy
    redirect_to list_path(@list)
  end

  def status
    status = params[:status]
    respond_to do |format|
      if @task.update!(status: status)
        format.turbo_stream
      else
        p 'something went wrong'
      end
    end
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def list_params
    params.require(:list).permit(tasks_attributes: [:_destroy,
                                                    :description,
                                                    :id,
                                                    :list_id])
  end

  def task_params
    params.require(:task).permit(:list_id, :description, :position, :status)
  end
end
