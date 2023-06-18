module PaymentHelper
    def razorpay_button(form, button_text)
        amount = form.object.amount
        currency = form.object.currency
    
        content_tag(:button, button_text, class: 'razorpay-payment-button', data: {
          'amount': amount,
          'currency': currency
        })
      end
end
