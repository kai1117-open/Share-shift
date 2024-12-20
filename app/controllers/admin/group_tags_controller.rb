class Admin::GroupTagsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_group_tag, only: [:show, :edit, :update, :destroy]

  def index
    if params[:q].present?
      # タグ名で検索
      @group_tags = GroupTag.where('tag_name LIKE ?', "%#{params[:q]}%")
    else
      @group_tags = GroupTag.all
    end
  end

  def show
  end

  def new
    @group_tag = GroupTag.new
    @groups = Group.all
  end

  def create
    @group_tag = GroupTag.new(group_tag_params)
    if @group_tag.save
      redirect_to admin_group_tags_path, notice: 'タグを作成しました。'
    else
      @groups = Group.all  # エラーが発生した場合もグループ名を再取得
      render :new
    end
  end

  def edit
  end

  def update
    if @group_tag.update(group_tag_params)
      redirect_to admin_group_tag_path(@group_tag), notice: 'タグが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @group_tag.destroy
    redirect_to admin_group_tags_path, notice: 'タグが削除されました。'
  end

  private

  # 共通のタグ検索処理
  def set_group_tag
    @group_tag = GroupTag.find(params[:id])
  end

  # Strong Parameters
  def group_tag_params
    params.require(:group_tag).permit(:content, :tag_name, :group_id)
  end
end
