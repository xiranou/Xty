class BraintreehooksController < ApplicationController
  def verify
    challenge = request.params["bt_challenge"]
    challenge_response = Braintree::WebhookNotification.verify(challenge)
    render text: challenge_response, status: 200
  end
end
