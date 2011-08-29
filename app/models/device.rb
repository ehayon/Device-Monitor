class Device < ActiveRecord::Base
  belongs_to :folder
  has_one :profile
  
  validates_presence_of :name, :description, :ip, :port, :folder_id
  validates_numericality_of :port, :greater_than => 0
  
  after_initialize :init

  def init 
    # Set some default values
    self.last_state ||= 0
    self.up_emails_sent ||= 0
    self.down_emails_sent ||= 0
    self.times_up ||= 0
    self.times_down ||= 0
    self.disabled ||= false
    self.last_checked ||= 15.minutes.ago
  end
  
  def self.to_be_checked
    Device.where("last_checked <= ?", 15.minutes.ago)
  end
  
end
