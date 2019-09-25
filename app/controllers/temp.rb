class MyapisController < ApplicationController

	before_action :init_user

	def new
		@article = @user.myapis.new
	end

	def create
		p "WITHIN CREATE"
		name = params['name']
		gApi = Globalapi.find_by_name[name]
		api_params = {"name" => gApi.name, "url" => gApi.url, "api" => gApi.api}
		if @myapi = @user.myapis.create(api_params)
			p "CREATED!!!!!!!!!!"
		end
		render 'weather#glocation'
	end

	def destroy
		@myapi = @user.myapis.find(params[:id])
		@myapi.destroy
		render 'welcome#index'
	end

	private

	def init_user
		@user = current_user
	end

	def check_params
		params.require(:myapi).permit(:name, :url, :api)
	end
end
