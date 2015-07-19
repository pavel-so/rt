class TrapsController < ApplicationController
  def index
    render text: 'Nothing is here.'
  end

  def create
    my_trap = Trap.where(name: params[:trap_name]).first_or_create!
    my_trap.add_entry(Entry.parse(request, cookies))
    render status: 200, nothing: true
  rescue StandardError => e
    render status: 500, nothing: true
  end
end
