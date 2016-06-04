require "sinatra"
require "sinatra/reloader"
enable :sessions
# this enables us to use PATCH and DELETE requests
use Rack::MethodOverride


get "/" do
@hash = {}


erb :team, layout: :layout2
end


post "/build" do
session[:team] = params[:names].split(',')
 @alert = "please make team size smaller" if params[:size].to_i > session[:team].length
 session[:hash] = {}
 if @alert == nil
    if params[:method]== "size"
      session[:hash] = size(session[:team], params[:size])
    else
      session[:hash] = number(session[:team], params[:size])
    end
 end
  erb :team, layout: :layout2
  redirect to("/")
end

def size(arr, size)
  teamsize =  size
  hash={}
  i  = 0
  while arr.length > 0
    team = "Team #{i+1}"
    temp = []
    teamsize.to_i.times do
    temp << arr.delete_at(rand(arr.length))
    end

    hash[team] = temp.compact
    i += 1
  end
hash
end


def number(arr, num)
  teamsize =  (arr.length / num.to_i)
  remainder = (arr.length % num.to_i)
  hash={}
  i  = 0
  while arr.length > 0
    team = "Team #{i+1}"
    temp = []
    teamsize.to_i.times do
    temp << arr.delete_at(rand(arr.length))
    end
    if remainder > 0
    temp << arr.delete_at(rand(arr.length))
    remainder -= 1 
    end
    hash[team] = temp.compact
    i += 1
  end
  hash
end
