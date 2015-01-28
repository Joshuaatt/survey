require 'bundler/setup'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
also_reload 'lib/**/*.rb'

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
  @survey = Survey.find(params.fetch("id").to_i)
  @questions = @survey.questions
  erb :survey
end

post '/surveys/:id' do
  @survey = Survey.find(params.fetch("id").to_i)
  question = Question.create({ prompt: params.fetch('prompt')})
  @survey.questions << question
  @questions = @survey.questions
  erb :survey
end

get '/surveys/:id/edit' do
  @survey = Survey.find(params.fetch('id').to_i)
  erb :survey_edit
end

patch '/surveys/:id/edit' do
  survey = Survey.find(params.fetch('id').to_i)
  survey.update({ name: params.fetch('name') })
  redirect '/'
end

delete '/surveys/:id/edit' do
  survey = Survey.find(params.fetch('id').to_i)
  survey.delete
  redirect '/'
end
