# == Schema Information
#
# Table name: traps
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Trap < ActiveRecord::Base
  has_many :entries, -> { order('created_at DESC') }
  validates :name, length: { in: 1..255 }

  def add_entry(entry)
    entries << entry
    # not the best solution but the quickest
    renderer = ActionView::Base.new(ActionController::Base.view_paths)
    class << renderer
      def protect_against_forgery?
        false
      end
      include Rails.application.routes.url_helpers
    end
    row = renderer.render(partial: 'entries/entry', locals: { entry: entry})
    Pusher.trigger(self.name, 'new_entry', {row: row})
  end
end
