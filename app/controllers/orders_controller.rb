class OrdersController < ApplicationController

    layout 'order'

    before_action :set_order, only: [:edit, :update]

    def index
        @order = Order.all
        @state = State.all
        @info = "Home"
    end

    def show
        @order = Order.find(params[:id])
    end

    def new
        @order = Order.new
        @info = "New"
    end

    def create
        @order = Order.create(params_order)
        unless @order.errors.any?
            redirect_to orders_path, alert: "Order successfully registered!"
        else
            render :new
        end
    end

    def edit
        @info = "Edit"
    end

    def update
        if @order.update(params_order)
            redirect_to orders_path, alert: "Order successfully edited!"
        else
            render :edit
        end
    end

    def destroy
    end

    def search
        if params[:search].blank?
            redirect_to(root_path, alert: "Empty search.") and return
        else
            @info = "Search Result"
            @parameter = params[:search].downcase
            @results = Order.all.where("lower(description) LIKE :search
                                        OR id LIKE :search",
                                        search: "%#{@parameter}%")
        end
    end

    
    private

    def set_order
        @order = Order.find(params[:id])
    end

    def params_order
        params.require(:order).permit(:id, :description, :state_id, :created_at, :updated_at)
    end

end
