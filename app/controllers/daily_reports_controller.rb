class DailyReportsController < ApplicationController
  # GET /daily_reports
  # GET /daily_reports.xml
  
  def index
    @daily_reports = DailyReport.all
   
    if request.xhr?
      render :json=> [1000,2000,3000]
      return
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @daily_reports }
    end
  end

  # GET /daily_reports/1
  # GET /daily_reports/1.xml
  def show
    @daily_report = DailyReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @daily_report }
    end
  end

  # GET /daily_reports/new
  # GET /daily_reports/new.xml
  def new
    @daily_report = DailyReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @daily_report }
    end
  end

  # GET /daily_reports/1/edit
  def edit
    @daily_report = DailyReport.find(params[:id])
  end

  # POST /daily_reports
  # POST /daily_reports.xml
  def create
    @daily_report = DailyReport.new(params[:daily_report])

    respond_to do |format|
      if @daily_report.save
        flash[:notice] = 'DailyReport was successfully created.'
        format.html { redirect_to(@daily_report) }
        format.xml  { render :xml => @daily_report, :status => :created, :location => @daily_report }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @daily_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /daily_reports/1
  # PUT /daily_reports/1.xml
  def update
    @daily_report = DailyReport.find(params[:id])

    respond_to do |format|
      if @daily_report.update_attributes(params[:daily_report])
        flash[:notice] = 'DailyReport was successfully updated.'
        format.html { redirect_to(@daily_report) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @daily_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_reports/1
  # DELETE /daily_reports/1.xml
  def destroy
    @daily_report = DailyReport.find(params[:id])
    @daily_report.destroy

    respond_to do |format|
      format.html { redirect_to(daily_reports_url) }
      format.xml  { head :ok }
    end
  end

  def every_mouth_income
#    if request.xhr?
#      @incomes=[1000,2000,2000,5000,4000,2000,5000,7000,7000,1000,5000,3000]
#      render :json=>@incomes
       @incomes=DailyReport.find_by_sql("select sum(income) as month_income from daily_reports where year(created_at)=#{params[:year]} group by month(created_at) order by created_at")
       render :json=>@incomes
#    end
  end



end
