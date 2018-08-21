class ContainersController < ApplicationController
  before_action :init_size_log, only: [:show]
  before_action  :set_container, only: [:show, :edit, :update, :destroy]
  
  # GET /containers
  # GET /containers.json
  def index
    start_containers()
    @containers = @server.containers
  end

  # GET /containers/1
  # GET /containers/1.json
  def show
    # TODO Exibir o log do container
   file_name = "docker_logs_#{Time.now.day.to_s}_#{Time.now.month.to_s}_#{Time.now.year.to_s}_#{@container.container_id}.txt"
    %x(#{access_server(@container.server)} docker logs --tail #{@size_log} #{@container.container_id} > #{file_name})

    states_file = File.open(file_name)
    @linhas = []

    while ! states_file.eof?
      line = states_file.gets.chomp
      @linhas << line
    end
  end

  # GET /containers/new
  def new
    # @container = Container.new
    # TODO Criar um container a partir de uma imagem 
  end

  # GET /containers/1/edit
  def edit
  end
  
  def restart
    # Restarta o container
    @container = set_container()
    container_id = @container.container_id
    acesso = "ssh #{@container.server.login}@#{@container.server.ip}"
    if %x(#{access_server(@container.server)} docker restart #{container_id})
      respond_to do |format|
        format.html { redirect_to server_container_path(@container.server.id, @container.id), notice: 'Container was successfully restarted.' }
        format.json { render :show, status: :ok, location: @container }
      end
    else
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end   
  end

  # POST /containers
  # POST /containers.json
  def create

  end

  # PATCH/PUT /containers/1
  # PATCH/PUT /containers/1.json
  def update
   
  end

  # DELETE /containers/1
  # DELETE /containers/1.json
  def destroy
    acesso = "ssh #{@container.server.login}@#{@container.server.ip}"
    container_id = @container.container_id
    if %x(#{access_server(@container.server)} docker stop #{container_id})
      respond_to do |format|
        format.html { redirect_to server_container_path(container.server.id, container.id), notice: 'Container was successfully stoped.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end  
  end

  private
    # Atualizar os container
    def start_containers
      @server = Server.find(params[:server_id])
      @server.containers.delete_all   
      %x(#{access_server(@server)} docker ps > docker_atual.txt)

      states_file = File.open("docker_atual.txt")
      linhas = []

      while ! states_file.eof?
        line = states_file.gets.chomp
        linhas << line.split('  ').delete_if {|l| l == ""}
      end
      objs = []
      cabecalho = linhas[0].map!{ |l| l.downcase  }.map! { |l| l.strip }.map! { |l| l.sub(" ", "_")  }
      linhas.delete(cabecalho)
      linhas.each do |item|
        @server.containers << Container.create(cabecalho.zip(item).to_h)
      end
    end 

    # Use callbacks to share common setup or constraints between actions.
    def set_container
      @container = Container.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def container_params
      params.require(:container).permit(:container_id, :image, :command, :create, :status, :ports, :name)
    end

    def access_server(server)
      port = server.port.blank? ? "" : " -p #{server.port}"
      acesso = "ssh #{port} #{server.login}@#{server.ip}"  
    end

    def init_size_log
      include = params.include? :size_log
      @size_log =  include ? params.require(:size_log)  : 100
    end
end
