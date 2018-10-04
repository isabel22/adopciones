class ReferencesController < ApplicationController
  def new
    @post = Post.find(params[id])
    respond_to do |format|
      format.js
    end
  end
end
