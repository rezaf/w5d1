class GoalsController < ApplicationController
  
  def new
    @goal = Goal.new
    render :new
  end
  
  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goal_url(@goal.id)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end
  
  def show
    @goals = Goal.all
    @goal = Goal.find(params[:id])
    @user = User.find_by_id(@goal.user_id)
  end
  
  private
  
  def goal_params
    params.require(:goal).permit(:body, :privacy)
  end
  
end
