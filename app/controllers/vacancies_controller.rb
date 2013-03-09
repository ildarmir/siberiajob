class VacanciesController < ApplicationController
  skip_before_filter :authorize, only: [:search, :show, :index]
  # GET /vacancies
  # GET /vacancies.json
  def index
    @vacancies = Vacancy.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vacancies }
    end
  end
  
  def search 
    
    @vacancies = Vacancy.search(params[:search])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vacancies }
    end
    
  end

  # GET /vacancies/1
  # GET /vacancies/1.json
  def show
    @vacancy = Vacancy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vacancy }
    end
  end
  
 

  # GET /vacancies/new
  # GET /vacancies/new.json
  def new
    @vacancy = Vacancy.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vacancy }
    end
  end

  # GET /vacancies/1/edit
  def edit
    @vacancy = Vacancy.find(params[:id])
  end

  # POST /vacancies
  # POST /vacancies.json
  def create
    
    @vacancy = Vacancy.new(params[:vacancy])
    @vacancy[:date] = Time.now
      
    respond_to do |format|
      if @vacancy.save
         sake=User.find_by_id(session[:user_id])
         if sake.vacancies_added==nil
         sake.vacancies_added="#{@vacancy.id},"
         else
         sake.vacancies_added+="#{@vacancy.id},"
         end
         sake.save
        format.html { redirect_to @vacancy, notice: 'Vacancy was successfully created.' }
        format.json { render json: @vacancy, status: :created, location: @vacancy }
      else
        format.html { render action: "new" }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # PUT /vacancies/1
  # PUT /vacancies/1.json
  def update
    @vacancy = Vacancy.find(params[:id])

    respond_to do |format|
      if @vacancy.update_attributes(params[:vacancy])
        format.html { redirect_to @vacancy, notice: 'Vacancy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vacancies/1
  # DELETE /vacancies/1.json
  def destroy
    @vacancy = Vacancy.find(params[:id])
    @vacancy.destroy

    respond_to do |format|
      format.html { redirect_to vacancies_url }
      format.json { head :no_content }
    end
  end
end
