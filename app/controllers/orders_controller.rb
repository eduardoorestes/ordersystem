class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update, :destroy]  
 
  def index
    @order = Order.all
    @q = Order.search(params[:q])
    if params[:q].blank?
      @result = nil
    else
      @result = @q.result()
    end
  end

  def new
    @order = Order.new
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
  end

  def update
    @order.complete if @order.in_progress?
    @order.progress if @order.pending?
    if @order.update(params_order)
      redirect_to orders_path, alert: 'Order successfully edited!'
    else
      render :edit
    end
  end
  
  def destroy
    if @order.destroy
      redirect_to orders_path, alert: 'Order successfully deleted'
    else
      render :index
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
