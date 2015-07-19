class TrapsController < ApplicationController
  def create
    trap = Trap.where(name: params[:id]).first_or_create!
    trap.entries << Entry.parse(request)
  end
end
