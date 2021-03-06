class NonprofitsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @nonprofits = Nonprofit.all
  end

  def new
    @nonprofit = Nonprofit.new
  end

  def create
    @nonprofit = Nonprofit.create(nonprofit_params)
    if @nonprofit.valid?
      flash[:notice] = "Your Non-Profit has been added!"
      redirect_to nonprofits_path
    else
      render "new"
    end
  end

  def show
    @nonprofit = Nonprofit.find(params[:id])
    @donations = @nonprofit.donations
  end

  def edit
    @nonprofit = Nonprofit.find(params[:id])
  end

  def update
    @nonprofit = Nonprofit.find(params[:id])
    if @nonprofit.update(nonprofit_params)
      flash[:notice] = "Your Non-Profit has been edited."
      redirect_to nonprofit_path(@nonprofit)
    else
      render "edit"
    end
  end

  def destroy
    @nonprofit = Nonprofit.find(params[:id])
    @nonprofit.destroy
    flash[:notice] = "Your Non-Profit has been exterminated! EXTERMINATED!"
    redirect_to nonprofits_path
  end

private
  def nonprofit_params
    params.require(:nonprofit).permit(:name, :email, :token, :recipient_token, :card_token)
  end
end
