# == Schema Information
#
# Table name: entries
#
#  id         :integer          not null, primary key
#  remote_ip  :string
#  query      :string
#  params     :text
#  headers    :text
#  cookies    :text
#  method     :string
#  raw_view   :text
#  trap_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Entry < ActiveRecord::Base
  belongs_to :trap

  serialize :headers
  store :params, coder: JSON
  serialize :cookies

  def self.parse(request, cookies)
    entry = Entry.new
    entry.headers = request.headers.select{ |key, val| key.match("^HTTP.*")}.to_a
    entry.method = request.method
    entry.remote_ip = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip # this is in case there is a transparent proxy
    entry.query = request.original_fullpath
    entry.cookies = cookies.to_a
    entry.params = request.parameters
    entry.raw_view = request.raw_post
    entry
  end

  def summary
    {id: id, method: method, }
  end
end
