require 'rubygems'
require 'sinatra'
require 'uri'
require 'net/https'
require 'json'

BAMBOO_USERNAME = ENV['BAMBOO_USERNAME']
BAMBOO_PASSWORD = ENV['BAMBOO_PASSWORD']
BAMBOO_HOST = ENV['BAMBOO_HOST']

BAMBOO_BUILD_BRANCH_VARIABLE = "buildBranch"

configure :production do
end

def build_branch(plan, branch)
  uri = URI.parse(BAMBOO_HOST)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = (uri.scheme == 'https')

  request = Net::HTTP::Post.new("/rest/api/latest/queue/#{plan}")
  request.set_form_data({ "os_authType" => "basic", "bamboo.variable.#{BAMBOO_BUILD_BRANCH_VARIABLE}" => branch })
  request.basic_auth(BAMBOO_USERNAME, BAMBOO_PASSWORD)
  response = http.request(request)

  response.body
end

def repository_to_plan(repository)
  ENV["REPOSITORY_#{repository}"]
end

def branch_from_payload(payload)
  if payload["ref"].match(/refs\/heads\/(.*)$/)
    $1
  else
    "master"
  end
end

get '/' do
  "OK"
end

post '/bambooBuild/:plan' do
  plan = params[:plan]
  branch = branch_from_payload(JSON.parse(params[:payload]))

  build_branch(plan, branch)
end
