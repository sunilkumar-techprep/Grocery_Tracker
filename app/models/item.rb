# == Schema Information
#
# Table name: items
#
#  id              :integer          not null, primary key
#  description     :text
#  expiration_date :date
#  image           :string
#  location        :string
#  name            :string
#  purchase_date   :date
#  quantity        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  category_id     :integer
#
class Item < ApplicationRecord
end
