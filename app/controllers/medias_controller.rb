class MediasController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  helper_method :join_on, :sort_column, :sort_direction
  
  add_breadcrumb "Media", :medias_path
  
  def new
   @media = Media.new
   if (params[:ascent_id])
     @media.ascent << Ascent.find(params[:ascent_id])
   end
  end
  
  def index
    @medias = Media.order(sort_column + " " + sort_direction).page(params[:page])  
  end
  
  def edit
    @media = Media.find(params[:id])
  end

  def show
    @media = Media.find(params[:id])
    add_breadcrumb @media.description, media_path(@media)
    @ascent = @media.ascent
    @climb = @media.climb
  end
  
  def update
      @media = Media.find(params[:id])
      if @media.update_attributes(params[:media])
        redirect_to @media, :notice => "Media updated."
      else
        redirect_to @media, :alert => "Unable to update media."
      end
    end

  def create
    @media = Media.new(params[:media])
    if @media.save
      flash[:success] = "Thanks for adding media!"
      redirect_to @media
    else
      render 'new'
    end
  end
    
  def destroy
    media = Media.find(params[:id])
    media.destroy
    redirect_to medias_path, :notice => "Media deleted."
  end
  
  private  
    def sort_column  
      params[:sort_column] || "created_at"  
    end  

    def sort_direction  
       %w[asc desc].include?(params[:sort_direction]) ?  params[:sort_direction] : "desc"  
    end
    
    def join_on
      params[:join_on] || nil
    end
    
end
