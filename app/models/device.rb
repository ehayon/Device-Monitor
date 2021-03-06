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
    self.last_checked ||= 5.minutes.ago
  end
  
  # Called from daemon - returns devices that need to be monitored now
  def self.to_be_checked
    Device.where("last_checked <= ?", 5.minutes.ago)
  end
  
  # Filter the results based on search terms
  def self.search(keyword, sort, folder)
    keyword ||= ''
    folder ||= ''
    results = []
    if folder == ''
      devices = Device.order("#{sort[:by]} #{sort[:dir]}")
    else
      devices = Device.where(:folder_id => folder).order("#{sort[:by]} #{sort[:dir]}")
    end
    devices.each do |device|
      if device.name.downcase =~ /.*#{keyword.downcase}.*/ or keyword.downcase =~ /.*#{device.name.downcase}.*/ or get_distance(keyword, device.name) <= 4 or
         device.ip.downcase =~ /.*#{keyword.downcase}.*/ or keyword.downcase =~ /.*#{device.ip.downcase}.*/
          results << device
      end
    end
    results
  end
  
  private
  # Levenshtein distance of two strings 
  def self.get_distance(s1 ,s2)
      m = Hash.new
      (s1.length + 1).times do |i|
        m.store([i,0], i)
      end
      (s2.length + 1).times do |i|
        m.store([0,i], i)
      end
      s2.length.times do |j|
        s1.length.times do |k|
          if (s1[k] == s2[j]) 
            m.store([k+1,j+1], m[[k,j]])
          else
            s = []
            s << m[[k, j]] << m[[k+1, j]] << m[[k, j+1]]
            m.store([k+1,j+1], s.min+1)
          end
        end
      end
      return m[[s1.length, s2.length]]
    end
  
 
   
end
