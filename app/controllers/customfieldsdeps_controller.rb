class CustomfieldsdepsController < ApplicationController
  unloadable
  layout 'admin'

  before_filter :require_admin

  def index
    list
  end
       
  def list
    @custs = Customfielddep.find(:all,:order=>'name')
    @customs = CustomField.find(:all,:conditions=>"type='IssueCustomField'",:order=>"name")
  end
  

  def save
	@custdep = Customfielddep.new(params[:customfielddep])
	if @custdep.name? and @custdep.custom_master_id!=@custdep.custom_slave_id and @custdep.save  
		flash[:notice] = l(:notice_successful_save)
      		redirect_to :action => "list", :id => params[:id]
	else
		flash[:notice] = l(:notice_unsuccessful_save)
		@customs = CustomField.find(:all,:conditions=>"type='IssueCustomField'",:order=>"name")
      		render :action => 'new'
	end
     
  end
  
  def new
    @custdep = Customfielddep.new
    @customs = CustomField.find(:all,:conditions=>"type='IssueCustomField'",:order=>"name")
  end
  
end
