class Public::GroupTagsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user

  def show
    @group_tag = GroupTag.find(params[:id])
  end

  private

  def ensure_guest_user
    if current_user.email == "guest@example.com"
      redirect_to public_user_path(current_user), notice: "ゲストユーザーの権限では不可能です"
    end
  end
end
