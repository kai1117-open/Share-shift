class Public::GroupsController < ApplicationController
  before_action :authenticate_user!  # ユーザーがログインしているか確認

  def index
    @groups = Group.all
    filter_groups_by_name
    filter_groups_by_prefecture
  end

  def show
    @group = Group.find(params[:id])
  end

  # ユーザーがグループに参加する処理
  def join
    @group = Group.find(params[:id])
    @membership = current_user.group_memberships.new(group: @group)

    if @membership.save
      redirect_to public_group_path(@group), notice: "グループに参加しました。"
    else
      redirect_to public_group_path(@group), alert: "すでにこのグループに参加しています。"
    end
  end

  def leave
    @group = Group.find(params[:id])
    current_user.group_memberships.find_by(group: @group).destroy
    redirect_to public_group_path(@group), notice: 'グループを退会しました。'
  end
  def search
    @groups = Group.all
    filter_groups_by_name
    filter_groups_by_prefecture
    render :index  # indexビューを再利用
  end

  private

  def filter_groups_by_name
    if params[:name].present?
      @groups = @groups.where('name LIKE ?', "%#{params[:name]}%")
    end
  end

  def filter_groups_by_prefecture
    if params[:prefecture_id].present?
      @groups = @groups.where(prefecture_id: params[:prefecture_id])
    end
  end

end
