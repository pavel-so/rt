class EntriesController < ApplicationController
  def index
    @trap = Trap.where(name: params[:trap_name]).first
    unless @trap
      render text: "Trap not found"
    end
  end

  def show
    @entry = Entry.joins(:trap).where(entries:{id: params[:id]}, traps:{name: params[:trap_name]}).first
  end
end
