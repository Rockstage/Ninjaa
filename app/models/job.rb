class Job < ActiveRecord::Base
  belongs_to :user
  attr_accessible :cash, :description, :title, :lat__c, :long__c

  validates :title, presence: true
  validates :description, presence: true
  validates :cash, presence: true
end
