class ImageDockersController < ApplicationController
  before_action :set_image_docker, only: [:show, :edit, :update, :destroy]

  # GET /image_dockers
  # GET /image_dockers.json
  def index
    start_images()
    @image_dockers = @server.image_dockers
  end

  # GET /image_dockers/1
  # GET /image_dockers/1.json
  def show
  end

  # GET /image_dockers/new
  def new
    @image_docker = ImageDocker.new
  end

  # GET /image_dockers/1/edit
  def edit
  end

  # POST /image_dockers
  # POST /image_dockers.json
  def create
    @image_docker = ImageDocker.new(image_docker_params)

    respond_to do |format|
      if @image_docker.save
        format.html { redirect_to @image_docker, notice: 'Image docker was successfully created.' }
        format.json { render :show, status: :created, location: @image_docker }
      else
        format.html { render :new }
        format.json { render json: @image_docker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /image_dockers/1
  # PATCH/PUT /image_dockers/1.json
  def update
    respond_to do |format|
      if @image_docker.update(image_docker_params)
        format.html { redirect_to @image_docker, notice: 'Image docker was successfully updated.' }
        format.json { render :show, status: :ok, location: @image_docker }
      else
        format.html { render :edit }
        format.json { render json: @image_docker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /image_dockers/1
  # DELETE /image_dockers/1.json
  def destroy
    @image_docker.destroy
    respond_to do |format|
      format.html { redirect_to image_dockers_url, notice: 'Image docker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_docker
      @image_docker = ImageDocker.find(params[:id])
    end

    def start_images
      @server = Server.find(params[:server_id])
      @server.image_dockers.delete_all
      %x(#{access_server(@server)} docker images > images.txt)

      states_file = File.open("images.txt")
      linhas = []

      while ! states_file.eof?
        line = states_file.gets.chomp
        linhas << line.split('  ').delete_if {|l| l == ""}
      end
      objs = []
      cabecalho = linhas[0].map!{ |l| l.downcase  }.map! { |l| l.strip }.map! { |l| l.sub(" ", "_")  }
      linhas.delete(cabecalho)
      linhas.each do |item|
        @server.image_dockers << ImageDocker.create(cabecalho.zip(item).to_h)
      end
    end

    def access_server(server)
      port = server.port.blank? ? "" : " -p #{server.port}"
      acesso = "ssh #{port} #{server.login}@#{server.ip}"  
    end
    

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_docker_params
      params.require(:image_docker).permit(:repository, :tag, :image_id, :created, :size)
    end
end
