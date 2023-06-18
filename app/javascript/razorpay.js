document.addEventListener("DOMContentLoaded", function() {
    var options = {
        key: "rzp_test_rxec7qHsjX5qSE",
        amount: document.getElementById("transaction_amount").value,
        currency: document.getElementById("transaction_currency").value,
        name: "Your Company Name",
        description: "Course Payment",
        order_id: "", // Will be dynamically generated and set in the Razorpay response
        handler: function(response) {
            // Handle the payment response
            console.log(response);
            if (response.razorpay_payment_id) {
                // Payment successful, submit the form
                document.getElementById("transaction-form").submit();
            } else {
                // Payment failed or canceled
                // Handle the error or show a message to the user
            }
        },
    };

    var razorpayButton = document.getElementById("razorpay-button");
    razorpayButton.addEventListener("click", function(e) {
        // Prevent the form submission
        e.preventDefault();

        // Create the Razorpay payment form
        var rzp = new Razorpay(options);
        rzp.open();
    });
});