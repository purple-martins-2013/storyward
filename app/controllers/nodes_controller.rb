class NodesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]

  def show
    @node = Node.find(params[:id])
  end

  def edit
    @node = Node.find(params[:id])
  end

  def update
    Node.find(params[:id])
    @node = Node.find(params[:id])
    unless @node.children_nodes.any?
      @node.update(nodes_params)
      @node.save
      redirect_to @node
    else
      redirect_to :back, notice: "Node cannot be edited because it has children."
    end
  end

  def destroy
    @node = Node.find(params[:id])
    unless @node.children_nodes.any?
      @node.destroy
      redirect_to root_url
    else
      redirect_to :back, notice: "Node cannot be deleted because it has children."
    end
  end

  def query
    @node = Node.find(params[:id])
    render json: @node.as_hash.to_json
  end

  def details
    @node = Node.find(params[:id])
    render json: create_json(@node)[0].to_json
  end

  def chain
    @node = Node.find(params[:id])
    render json: build_chain(@node).reverse.to_json
  end

  private
  def nodes_params
    params.require(:node).permit(:title, :content) 
  end
end
