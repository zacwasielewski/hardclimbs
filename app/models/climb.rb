# == Schema Information
#
# Table name: climbs
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  style_id       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  slug           :string(255)
#  still_hard     :boolean          default(TRUE)
#  area_id        :integer
#  climbers_count :integer          default(0)
#  ascents_count  :integer          default(0)
#  medias_count   :integer          default(0)
#  grade_id       :integer
#

class Climb < ActiveRecord::Base
  extend FriendlyId
    friendly_id :name, :use => :slugged
  validates_presence_of :slug  
  
  attr_accessible :name, :media_ids, :style_id, :still_hard, :area_id, :grade_id
  has_many :climbers, :through => :ascents
  has_many :ascents
  has_and_belongs_to_many :medias, :class_name => 'Media'
  accepts_nested_attributes_for :medias
  belongs_to :style
  belongs_to :area
  validates_presence_of :style, :area, :grade
  belongs_to :grade
  
  counter_culture :area
  counter_culture :grade
  
  validates :name, :uniqueness => {:scope => :area_id, :message => "That climb already exists in this area!"}
  
  def climb_area_name
    "#{name} (#{area.name})"
  end
  
  def proposed_grade
    if !grade
      "Unknown"
    else
      grade.name
    end
  end
  
  def self.order_by_join(join_model, sort_column, sort_direction = 'asc')
      if join_model == nil
        order("#{sort_column} #{sort_direction}")
      else
        joins(join_model.parameterize.underscore.to_sym).order("#{sort_column} #{sort_direction}")
      end
  end
  
end
