# == Schema Information
#
# Table name: items
#
#  id              :integer          not null, primary key
#  category        :string
#  description     :text
#  expiration_date :date
#  image           :string
#  location        :string
#  name            :string
#  purchase_date   :date
#  quantity        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#


class Item < ApplicationRecord
  #validates :name, presence: true, format: { with: /\A[a-zA-Z ]+\z/, message: "only allows letters and spaces" }
  #validates :purchased_date, presence: true
  #validates :expiration_date, presence: true
  #validates :quantity, presence: true, unless: :description_present?
  #validates :description, presence: true, unless: :quantity_present?
  #validate :expiration_date_greater_than_or_equal_to_purchase_date
  #validates :location, presence: true, format: { with: /\A[a-zA-Z0-9!@#$%^&*()_+=\-,. ]+\z/, message: "only allows letters, numbers, and symbols" }
  #validates :categories, presence: true

  #def description_present?
    #description.present?
  #end

  #def quantity_present?
    #quantity.present?
  #end

  #def expiration_date_greater_than_or_equal_to_purchase_date
    #if purchase_date.present? && expiration_date.present? && expiration_date < purchase_date
      #errors.add(:expiration_date, "must be greater than or equal to purchased date")
    #end

  #end

  #def self.same_name_with_different_quantity_or_description(item)
   # where("name = ? AND (quantity != ? OR description != ?)", item.name, item.quantity, item.description).exists?
  #end
end
