class DevicesController < ApplicationController
  def index
    @folders = Folder.all
    params[:sort] ||= {'by'=>'id', 'dir'=>'asc'}
    params[:search] ||= ""
    @devices = Device.search(params[:search], params[:sort], params[:folder])
    json_response = { 'sort' => { 'by' => 'id', 'dir' => 'asc' }, 'devices' => @devices}
    respond_to do |format|
      format.html
      format.json { render :json => json_response, :status => :ok }
    end
  end

  def new
    @device = Device.new
    @folders = Folder.all
  end
  def create
    @device = Device.new(params[:device])
    @folders = Folder.all
    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, :notice => "Device created!" }
        format.xml { render :xml => @device, :status => :created, :location => @device }
      else
        format.html { render "new" }
        format.xml { render :xml => @device.errors, :status => :unprocessable_entity }
      end
      
    end
  end
  
  def show
    @device = Device.find(params[:id])
    @uptime = (@device.times_up == 0 && @device.times_down == 0) ? 0 : (@device.times_up/(@device.times_up + @device.times_down))*100
  end

  def edit
    @device = Device.find(params[:id])
    @folders = Folder.all
  end
  def update
    @device = Device.find(params[:id])
    @device.last_checked = 5.minutes.ago
    respond_to do |format|
      if @device.update_attributes(params[:device])
        format.html { redirect_to @device, :notice => "Device updated!" }
        format.xml { head :ok }
      else
        format.html { render 'edit' }
        format.xml { render :xml => @device.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @device = Device.find(params[:id])
    @device.destroy
    redirect_to devices_path
  end
  
end

