class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :title, presence: true
  validates_uniqueness_of :title, scope: :category
  
  
  def self.sort_by_category(category)
    list = Work.where(category: category)
    return list.sort_by {|work| work.votes.length}.reverse
  end
  
  def self.top_ten(category)
    sort_by_category(category).slice(0..9)
  end
  
  def self.spotlight
    Work.all.sort_by {|work| work.votes.length}.reverse.slice(0)
  end
  
end