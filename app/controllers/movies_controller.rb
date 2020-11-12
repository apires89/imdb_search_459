class MoviesController < ApplicationController
  def index
    if params[:query].present?
        # sql_query = " \ Postgres multiple search
        # movies.title @@ :query \
        # OR movies.syllabus @@ :query \
        # OR directors.first_name @@ :query \
        # OR directors.last_name @@ :query \
      # "
      # sql_query = " \  Multiple search + Association search
      #   movies.title ILIKE :query \
      #   OR movies.syllabus ILIKE :query \
      #   OR directors.first_name ILIKE :query \
      #   OR directors.last_name ILIKE :query \
      # "
      #sql_query = "title ILIKE :query OR syllabus ILIKE :query" multiple seach in syllabus and title
      #@movies = Movie.where(title: params[:query]) exact match
      #@movies = Movie.where("title ILIKE ?", "%#{params[:query]}") exact match but case insensitive
      #@movies = Movie.where(sql_query, query:  "%#{params[:query]}%" ) multiple seach in syllabus and title
      # @movies = Movie.joins(:director).where(sql_query, query:  "%#{params[:query]}%" )
      # @movies = Movie.search_by_title_and_syllabus(params[:query])
      @movies = Movie.global_search(params[:query])
      # @results = PgSearch.multisearch(params[:query]) carefull with this one!
    else
      @movies = Movie.all
    end
  end
end
