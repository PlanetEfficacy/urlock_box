class Link < ApplicationRecord
  belongs_to :user
  validates_presence_of :url
  validates_presence_of :title
  validates_presence_of :status
  validates :url, :url => true
end
