class DevicesController < ApplicationController
  def index
    @devices = Device.all
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
  end

  def edit
    @device = Device.find(params[:id])
    @folders = Folder.all
  end
  def update
    @device = Device.find(params[:id])
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
  
  
  def datatable
    @devices = Device.all
    respond_to do |format| 
      format.json { render :json => generate_json(@devices) }
    end
  end 
  
  private 
  def generate_json(objects)   
    # generate the json used by datatables
    data = []
    objects.each do |object|
      data << [object.name, object.ip, object.port.to_s, object.last_state.to_s, 'link']
    end
    { :sEcho => 1, :iTotalRecords => objects.count, :iTotalDisplayRecords => objects.count, :aaData => data}.to_json
  end
end

