class ClientsController < ApplicationController
  before_action :set_client, only: %i[show edit update destroy]
  def index
    @clients = Client.all
  end

  def show
  end

  def new
    @client = Client.new
  end

  def edit
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      flash[:success] = "Client created"
      redirect_to clients_path
    else
      render :new
    end
  end

  def update
    if @client.update(client_params)
      flash[:success] = "Client updated"
      redirect_to clients_path
    else
      render :edit
    end
  end

  def destroy
    begin
      @client.destroy
      flash[:success] = "Client deleted"
    rescue
      flash[:error] = "Could not delete client #{@client.name}"
    end

    redirect_to clients_path
  end

  private
  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:name, :last_name, :email, :phone_number)
  end
end
