class CommonUsersController < ApplicationController
	public
  def index
  #   userの一覧を表示
    @test = "test a"
    @allusers = User.all.includes(:person_info)
  end

  def add
    render :text => "render test"
  end

  def details
  end
end
