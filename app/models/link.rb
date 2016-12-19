class Link < ApplicationRecord
  validates_presence_of :url
  validates_presence_of :title
  validates :url, :url => true
end
