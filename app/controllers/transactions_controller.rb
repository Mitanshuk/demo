class TransactionsController < ApplicationController
  require 'razorpay'
    before_action :set_transaction, only: [:show, :edit, :update, :destroy]

    def index
      @transactions = Transaction.all
    end

    def show
    end

    def new
      @transaction = Transaction.new
    end

    def create
      @transaction = Transaction.new(transaction_params)
      @transaction.student_id = current_user.id
  
      if @transaction.save
        order = create_razorpay_order(@transaction.amount, @transaction.currency)
        @transaction.update(razorpay_order_id: order.id)
  
        redirect_to payment_path(@transaction)
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @transaction.update(transaction_params)
        redirect_to @transaction, notice: 'Transaction was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @transaction.destroy
      redirect_to transactions_url, notice: 'Transaction was successfully destroyed.'
    end

    private

    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def transaction_params
      params.require(:transaction).permit(:course_id, :student_id, :tutor_id, :status)
    end

    def create_razorpay_order(amount, currency)
      client = Razorpay::Client.new(api_key: 'rzp_test_rxec7qHsjX5qSE', api_secret: 'Jbe2HGHVd3qPVaRdyL7w3oCQ')
      order = client.order.create(amount: amount, currency: currency)
  
      order
    end
  end
