class Public::GroupTagsController < ApplicationController
  def show
    @group_tag = GroupTag.find(params[:id])
  end
end
