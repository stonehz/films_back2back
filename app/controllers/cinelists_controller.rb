class CinelistsController < ApplicationController
  # GET /cinelists
  # GET /cinelists.json
  def index
    @cinelists = Cinelist.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cinelists }
    end
  end

  # GET /cinelists/1
  # GET /cinelists/1.json
  def show
    @cinelist = Cinelist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cinelist }
    end
  end

  # GET /cinelists/new
  # GET /cinelists/new.json
  def new
    @cinelist = Cinelist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cinelist }
    end
  end

  # GET /cinelists/1/edit
  def edit
    @cinelist = Cinelist.find(params[:id])
  end

  # POST /cinelists
  # POST /cinelists.json
  def create
    @cinelist = Cinelist.new(params[:cinelist])

    respond_to do |format|
      if @cinelist.save
        format.html { redirect_to @cinelist, notice: 'Cinelist was successfully created.' }
        format.json { render json: @cinelist, status: :created, location: @cinelist }
      else
        format.html { render action: "new" }
        format.json { render json: @cinelist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cinelists/1
  # PUT /cinelists/1.json
  def update
    @cinelist = Cinelist.find(params[:id])

    respond_to do |format|
      if @cinelist.update_attributes(params[:cinelist])
        format.html { redirect_to @cinelist, notice: 'Cinelist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cinelist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cinelists/1
  # DELETE /cinelists/1.json
  def destroy
    @cinelist = Cinelist.find(params[:id])
    @cinelist.destroy

    respond_to do |format|
      format.html { redirect_to cinelists_url }
      format.json { head :no_content }
    end
  end
end
