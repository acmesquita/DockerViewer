class ContainersController < ApplicationController
  before_action  :set_container, only: [:show, :edit, :update, :destroy]

  # GET /containers
  # GET /containers.json
  def index
    start_containers()
    @containers = Container.all
  end

  # GET /containers/1
  # GET /containers/1.json
  def show
    # TODO Exibir o log do container
    file_name = "docker_logs_#{Time.now.day.to_s}_#{Time.now.month.to_s}_#{Time.now.year.to_s}_#{@container.container_id}.txt"
    %x(docker logs --tail 100 #{@container.container_id} > #{file_name})

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
    if %x(docker restart #{container_id})
      respond_to do |format|
        format.html { redirect_to @container, notice: 'Container was successfully restarted.' }
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

    container_id = @container.container_id
    if %x(docker stop #{container_id})
      respond_to do |format|
        format.html { redirect_to containers_url, notice: 'Container was successfully stoped.' }
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
      Container.delete_all
      %x(docker ps > docker_atual.txt)

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
        Container.create(cabecalho.zip(item).to_h)
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
end
