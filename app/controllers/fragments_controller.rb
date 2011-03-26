class FragmentsController < ApplicationController
  before_filter :find_fragment, :only => [:show, :update]

  def show
    render :json => @fragment
  end

  def create
    Fragment.create!(params[:fragment])
    render :json => @fragment.to_json
  rescue
    render :text => "Invalid fragment", :status => 400
  end

  def update
    if @fragment.update_attributes(params[:fragment])
      render :json => @fragment
    else
      render :text => "Invalid fragment", :status => 400
    end
  end

  def destroy
    Fragment.delete(params[:id])
    render :text => 'Fragment removed'
  end

  private
  def find_fragment
    @fragment = Fragment.find(params[:id])
  end
end