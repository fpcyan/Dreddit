class SubsController < ApplicationController

  before_action :ensure_only_moderators_can_edit_subs, only: [:edit, :update]

  def show
    @sub = Sub.includes(:posts => :author).find(params[:id])
    render :show
  end

  def index
    @subs = Sub.all

    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params.merge(moderator_id: current_user.id))

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private

    def sub_params
      params.require(:sub).permit(:title, :description)
    end

    def ensure_only_moderators_can_edit_subs
      @sub = Sub.find(params[:id])
      redirect_to sub_url(@sub) unless current_user.id == @sub.moderator_id
    end
end
