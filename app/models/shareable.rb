class Shareable < ActiveRecord::Base
  attr_accessible :client_id, :campaign, :version, :shareable, :destination, :short
  validates_presence_of :client_id
  belongs_to :client
  has_many :clicks
  
  BASE_URL = "http://www.inv.to/"
  CHARSET = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  BASE = 62
  CODE_LENGTH = 6

  def self.encode(sal)
    code = ""
    while (sal > 0) do
      code = CHARSET[sal % BASE].chr + code
      sal = sal / BASE
    end

    temp = (code.length > CODE_LENGTH) ? "" : "0" * (CODE_LENGTH - code.length) + code 
    temp 
  end

  def self.decode(code)
    return -1 if code.length != CODE_LENGTH
    id = 0
    for i in 0..(CODE_LENGTH-1) do
      n = CHARSET.index(code[i])
      return -1 if n.nil?
      id += n * (BASE ** (CODE_LENGTH - i - 1))
    end
    return id
  end
  
  def shorten!
    self.short = Shareable.encode(self.id)
    self.shareable = BASE_URL + self.short
    self.save!
  end
  
  def as_json(options={})
    super(options.merge({ :only => [:client_id, :campaign, :version, :destination, :short, :shareable]}))
  end
    
end
