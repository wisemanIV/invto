class EmailsController < ApplicationController
  before_filter :authenticate_user!
  # GET /emails
  # GET /emails.json
  def index
    @emails = Email.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @emails }
    end
  end

  # GET /emails/1
  # GET /emails/1.json
  def show
    @email = Email.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @email }
    end
  end

  # GET /emails/new
  # GET /emails/new.json
  def new
    @email = Email.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @email }
    end
  end

  # GET /emails/1/edit
  def edit
    @email = Email.find(params[:id])
  end

  # POST /emails
  # POST /emails.json
  def create
      
    Mail.defaults do
      delivery_method :smtp, { :address   => "smtp.sendgrid.net",
                               :port      => 587,
                               :domain    => "gametimesf.com",
                               :user_name => ENV["SENDGRID_USERNAME"],
                               :password  => ENV["SENDGRID_PASSWORD"],
                               :authentication => 'plain',
                               :enable_starttls_auto => true }
    end
    
    saved = true ;
    
    emails = params[:email]
    
    emails.each do |value|
      
      recipients = value[:to].split(/,/)
      
      template = EmailTemplate.where("name = :template", { :template => value[:template]}).first
      
      @email = Email.new(:from => template.from, :email_template_id => template.id, :to => value[:to], :client_id => value[:client_id], :ref => value[:ref])
      
      subj = "#{template.subject}"
      subj = subj.sub("<toname>", value[:toname])
      bodt = template.body.sub("<toname>", value[:toname])

      mail = Mail.deliver do
        to recipients
        from template.from
        subject subj
        html_part do
          content_type 'text/html; charset=UTF-8'
          body bodt
        end
      end
      
      if !@email.save
        saved = false
        break ;
      end
      
    end

    respond_to do |format|
      if saved
        format.html { redirect_to @email, notice: 'Email was successfully created.' }
        format.json { render json: @email, status: :created, location: @email }
      else
        format.html { render action: "new" }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /emails/1
  # PUT /emails/1.json
  def update
    @email = Email.find(params[:id])

    respond_to do |format|
      if @email.update_attributes(params[:email])
        format.html { redirect_to @email, notice: 'Email was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emails/1
  # DELETE /emails/1.json
  def destroy
    @email = Email.find(params[:id])
    @email.destroy

    respond_to do |format|
      format.html { redirect_to emails_url }
      format.json { head :no_content }
    end
  end
end
