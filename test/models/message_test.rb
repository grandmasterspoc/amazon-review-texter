# == Schema Information
#
# Table name: messages
#
#  id                  :integer          not null, primary key
#  product_id          :integer
#  sms_message         :text
#  user_number         :string
#  user_name           :string
#  product_name        :string
#  review_redirect_url :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end