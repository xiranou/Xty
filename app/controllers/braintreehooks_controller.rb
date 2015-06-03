class BraintreehooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def verify
    challenge = request.params["bt_challenge"]
    challenge_response = Braintree::WebhookNotification.verify(challenge)
    render text: challenge_response, status: 200
  end

  def merchant_status_update
    notification = Braintree::WebhookNotification.parse(
      params[:bt_signature],
      params[:bt_payload]
    )
    if notification.kind == Braintree::WebhookNotification::Kind::SubMerchantAccountApproved
      artist = Artist.find_by(braintree_id: notification.merchant_account.id)
      artist.update_attributes(merchant_status: notification.merchant_account.status)
      render nothing: true, status: 200
    else
      redirect_to new_artists_path, alert: notification.message
    end
  end
end
