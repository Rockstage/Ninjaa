class JobsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]
  before_filter :find_user
  before_filter :find_job, only: [:edit, :update, :destroy]
  # before_filter :ensure_proper_user, only: [:edit, :update, :delete]
  # GET /jobs
  # GET /jobs.json
  def index
    #@jobs = Job.all
    @jobs = Job.all(:order => 'updated_at DESC')
    #@jobs = @user.jobs.all(:order => 'updated_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.json
  def new
    #@job = Job.new
    if current_user.role == true
      @job = current_user.jobs.new
    else
      flash[:error] = "You must be a sensei to do that. Re-chose your path by editing your profile."
      redirect_to root_path
    end

    #respond_to do |format|
    #  format.html # new.html.erb
    #  format.json { render json: @job }
    #end
  end

  # GET /jobs/1/edit
  def edit
    #@job = Job.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.json
  def create
    #@job = Job.new(params[:job])
    @job = current_user.jobs.new(params[:job])
    

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render json: @job, status: :created, location: @job }
      else
        format.html { render action: "new" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.json
  def update
    #@job = Job.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    #@job = Job.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url }
      format.json { head :no_content }
    end
  end


  def url_options
    { profile_name: params[:profile_name] }.merge(super)
  end

  private

  def ensure_proper_user
    if current_user != @user
      flash[:error] = "You don't have premission to do that."
      redirect_to root_path
    end
  end

  def find_user
    @user = User.find_by_profile_name(params[:profile_name])
  end

  def find_job
    @job = current_user.jobs.find(params[:id])
  end



end
