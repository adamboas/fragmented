class FragmentsController < ApplicationController
  before_filter :find_fragment, :only => [:show, :update, :destroy]

  def show
    render :json => @fragment.to_json
  end

  def create
    @fragment = Fragment.build(params[:fragment])
    if @fragment.save
      render :json => @fragment.to_json
    else
      render :text => "Invalid fragment", :status => 400
    end
  end

  def update
    @fragment.update_attributes(params[:fragment])
    if @fragment.save
      render :json => @fragment.to_json
    else
      render :text => "Invalid fragment", :status => 400
    end
  end

  def destroy
    Fragment.delete(@fragment)
    render :text => 'Fragment removed'
  end

  def find_fragment
    @fragment = Fragment.find(params[:id])
  end
end