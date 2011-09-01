class FoldersController < ApplicationController
  def index
    @folders = Folder.all
  end

  def new
    @folder = Folder.new
  end
  def create
    @folder = Folder.new(params[:folder])
    respond_to do |format|
      if @folder.save
        format.html { redirect_to @folder, :notice => "Folder created!" }
        format.xml  { render :xml => @folder, :status => :created, :location => @folder }
      else
        format.html { render "new" }
        format.xml  { render :xml => @folder.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @folder = Folder.find(params[:id])
  end
  def update
    @folder = Folder.find(params[:id])
    respond_to do |format|
       if @folder.update_attributes(params[:folder])
         format.html { redirect_to @folder, :notice => "Folder Updated" }
         format.xml  { head :ok }
       else
         format.html { render 'edit' }
         format.xml  { render :xml => @folder.errors, :status => :unprocessable_entity }
       end
    end
   
  end

  def show
    @folder = Folder.find(params[:id])
  end

end
