module UserCart
  extend ActiveSupport::Concern

  def current_user_cart
    "cart#{current_user.id}"
  end
end