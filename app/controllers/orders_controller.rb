class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update]

  def index
    @order = Order.all
    @info = 'Home'
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @info = 'New'
  end

  def create
    if params_order.blank?
      redirect_to orders_path, alert: 'Order unregistred (Empty Order).'
    else
      @order = Order.create(params_order)
      unless @order.errors.any?
        redirect_to orders_path, alert: 'Order successfully registered!'
      else
        render :new
      end
    end
  end

  def edit
    @info = 'Edit'
  end

  def update
    @order.complete if @order.in_progress?
    @order.progress  if @order.pending?
    ##
    #  if @order.pending?
    #    @order.progress
    #  elsif @order.progress
    #    @order.complete
    #  end
    ##
    if @order.update(params_order)
      redirect_to orders_path, alert: 'Order successfully edited!'
    else
      render :edit
    end
  end
  
  def destroy
  end

  def search
    if params[:search].blank?
      redirect_to(root_path, alert: 'Empty search.')
    else
      @info = 'Search Result'
      @results = Order.where('description LIKE :search OR id = :search', search: '%'+"#{params[:search]}"+'%')
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def params_order
    params.require(:order).permit(:id, :description, :aasm_state)
  end

end
