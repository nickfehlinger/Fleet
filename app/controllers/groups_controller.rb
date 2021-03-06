class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    redirect_to '/'
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  @trips = Trip.new group_id: @group.id
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    respond_to do |format|
      if @group.save
        GroupUser.create(user_id: current_user.id, group_id: @group.id)
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def group_user
    @user = User.find_by(id: params[:user_id])
    @group = Group.find_by(id: params[:group_id])
    GroupUser.create(user_id: @user.id, group_id: @group.id)
    redirect_back(fallback_location: group_path(@group))
  end
  def destroy_group_user
    @group_user = GroupUser.where("user_id LIKE '%#{params[:user_id]}%' AND group_id LIKE '%#{params[:group_id]}%'")
    @group_user.destroy_all
    redirect_back(fallback_location: root_path)
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :description, :start, :end)
    end
end
