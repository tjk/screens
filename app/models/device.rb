class Device < ActiveRecord::Base
  include ActiveModel::Validations
  include DevicesHelper
  validates :name, :presence => true
  validates :deviceid, :uniqueness => true,
            :format => { :with => /([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}/,
                         :message => "MAC address must match format: 'AB:CD:EF:00:22:33'" }
  before_save :upcase_deviceid

  belongs_to :slideshow

  attr_accessible :name, :slideshow_id, :password, :deviceid

  def thumbnail
    device_thumbnail(self)
  end

  def pid
    device_pid(self)
  end

  def slideshow_name
    slideshow.name if slideshow
  end

  def upcase_deviceid
    self.deviceid and self.deviceid.upcase!
    true
  end
end
