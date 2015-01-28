require 'bundler/setup'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


get '/' do
  @surveys = Survey.all
  erb :index
end

post '/' do
  survey = Survey.create({ name: params.fetch('name') })
  @surveys = Survey.all
  erb :index
end

get '/surveys/:id' do
  @questions = Question.all
  @survey = Survey.find(params.fetch("id").to_i)
  erb :survey
end

post '/surveys/:id' do
  @survey = Survey.find(params.fetch("id").to_i)
  question = Question.create({ prompt: params.fetch('prompt')})
  @questions = Question.all
  erb :survey
end
