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

class Message < ActiveRecord::Base
  belongs_to :user
  after_save :send_message

   def send_message
    @user_message = user_message
    api = Twilio::REST::Client.new ENV['AMAZONIAN_TWILIO_ACCOUNT_SID'], ENV['AMAZONIAN_TWILIO_AUTH_TOKEN']
    api.messages.create(
      :from => '+13853753097',
      :to => user_reformatted_number,
      :body => @user_message
    )
  end

  def user_reformatted_number
    puts user_number
    user_number.gsub(/[^\d]/, '')
  end  

  def user_message
    bit_link = bitly_link
    name = self.user_name
    "\nHey #{name}, thanks in advance for leaving a quick review. Just follow this link\n#{bit_link}\n\n\nLet me know if you have any questions!"
  end  

  def bitly_link
    bitly_object = Bitly.client.shorten(review_redirect_url)
    puts bitly_object.short_url
    bitly_object.short_url
  end  
end

