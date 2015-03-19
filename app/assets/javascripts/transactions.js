if (typeof gon !=='undefined') {
  braintree.setup(gon.client_token, 'dropin', { container: 'dropin' });
}