class PostsController < ApplicationController
	before_action :set_post, only: [:update, :edit, :destroy]
	def create
		@post = current_user.posts.new(post_params) ### associated with the current user and pass through post params)
		if @post.save
			@post.create_activity key: 'post.created', owner: @post.user
			respond_to do |format|
				format.html { redirect_to user_path(@post.user.username), notice: "Post Created"} ### rake routes... needs an id to pass through ... params user controller  
			end 
		else
			redirect_to user_path(@post.user.username), notice: "Something went wrong."
		end
	end

	def edit

	end

	def update
		if @post.update(post_params)  ###pass through params
			respond_to do |format|
				format.html {redirect_to user_path(@post.user.username), notice: "Post updated."}
			end
		else
			redirect_to user_path(@post.user.username), notice: "Something went wrong"
		end
	end

	def destroy
		@post.destroy
		respond_to do |format| 
			format.html {redirect_to user_path(@post.user.username), notice: "Post Deleted"}
		end
	end

	private

	def set_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:content) ####user id not needed because its already in the created process (current_user.posts...)
	end

end