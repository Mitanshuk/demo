class PaymentsController < ApplicationController
    def new
      @course = Course.find(params[:course_id])
      @payment = @course.payments.build(amount: @course.price)
    end
  
    def create
      @payment = Payment.new(payment_params)
      if @payment.save
        # Initialize Razorpay client
        razorpay_client = Razorpay::Client.new
  
        # Create a Razorpay order
        razorpay_order = razorpay_client.order.create(
          amount: @payment.amount * 100,  # Amount in paise
          currency: 'INR',
          receipt: @payment.id.to_s,
          payment_capture: 1
        )
  
        # Redirect user to Razorpay payment page
        redirect_to razorpay_order['url']
      else
        # Handle payment validation errors
        render :new
      end
    end
  
    private
  
    def payment_params
      params.require(:payment).permit(:course_id, :amount)
    end
  end
  