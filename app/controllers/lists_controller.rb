class ListsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_list, except: [:index, :new, :create]

  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    respond_to do |format|
      if @list.save
        flash[:notice] = "List was created"
        format.turbo_stream { render_flash }
        format.html { redirect_to list_path(@list)}
      else
        format.html { render :new, status: :unprocessable_entity, notice: "Sorry, but your list was not created, please try again." }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @list.update(list_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@list),
                                     partial: 'lists/list') }
        format.html { redirect_to lists_path }
      else
        format.html { render :new, status: :unprocessable_entity, notice: "Sorry, but your list was not updated, please try again." }
      end
    end
  end

  def destroy
    @list.destroy
    respond_to do |format|
      flash.now[:notice] = "List was deleted"
      format.turbo_stream { render_flash }
      format.html { redirect_to lists_path }
    end
  end

  def show; end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name,
                                 tasks_attributes: [:_destroy,
                                                    :description,
                                                    :id,
                                                    :list_id])
  end
end