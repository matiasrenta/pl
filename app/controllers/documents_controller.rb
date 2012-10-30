class DocumentsController < ApplicationController
  #skip_authorization_check
  load_and_authorize_resource :except => :index

  def index
    @documents = do_index(Document, params)
  end

  def show
    puts "@@@@@@@@@@@@@@@@@@@@@" + @document.file.url
    puts "@@@@@@@@@@@@@@@@@@@@@" + @document.file.path
    send_file(@document.file.url, :filename => @document.file.url.split("/").last, :disposition => 'attachment')
  end

  def new

  end

  def create
    respond_to do |format|
      if @document.save
        format.html { redirect_to(actual_project, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @document, :status => :created, :location => @document }
      else
        format.html { redirect_to(actual_project) }
        format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to(actual_project, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { redirect_to(actual_project) }
        format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    prudent_destroy(Document.find(params[:id]))
  end

end
