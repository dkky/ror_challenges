// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


let braintreeClientCreateHandler = function(clientErr,clientInstance) {
	if (clientErr) {
		alert(clientErr);
		console.log(clientErr);
		return;
	}


  braintree.hostedFields.create({
    client: clientInstance,
    fields: {
      number: {
        selector: '#card-number',
        placeholder: '4111 1111 1111 1111'
      },
      cvv: {
        selector: '#cvv',
        placeholder: '123'
      },
      expirationDate: {
        selector: '#expiration-date',
        placeholder: '10 / 2019'
      }
    }
   }, hostedFieldsHandler);
	let submit = document.querySelector('input[type="submit"]');
    submit.removeAttribute('disabled');
  
};


let hostedFieldsHandler= function(hostedFieldsErr,hostedFieldsInstance) {
	if (hostedFieldsErr) {
		alert();
		return;
	}

	let form = document.querySelector('#checkout-form');
	form.addEventListener('submit',function(event) {
		event.preventDefault();


      	hostedFieldsInstance.tokenize(function (tokenizeErr, payload) {
        if (tokenizeErr) {
          // Handle error in Hosted Fields tokenization
          return;
        }

        // Put `payload.nonce` into the `payment-method-nonce` input, and then
        // submit the form. Alternatively, you could send the nonce to your server
        // with AJAX.
        document.querySelector('input[name="checkout_form[payment_method_nonce]"]').value = payload.nonce;
        form.submit();
      	});
    }, false);
};

jQuery(document).ready(function(){
	var authorization;
	$.ajax({
		dataType: "json",
		url: "/transactions/client_token",
		success: function(data) {
			authorization = data.client_token;
			braintree.client.create({
				authorization: authorization
			}, braintreeClientCreateHandler);
		}
	})
});
