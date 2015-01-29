require 'bundler/setup'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
also_reload 'lib/**/*.rb'

get '/' do
  @surveys = Survey.all
  erb :index
end

post '/' do
  @survey = Survey.create({ name: params.fetch('name') })
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

get '/questions/:id/edit/:survey_id' do
  @survey_id = params.fetch('survey_id').to_i
  @question = Question.find(params.fetch('id').to_i)
  erb :question_edit
end

patch '/questions/:id/edit' do
  survey_id = params.fetch('survey_id')
  question = Question.find(params.fetch('id').to_i)
  new_prompt = params.fetch('prompt')
  question.update({ prompt: new_prompt})
  redirect '/surveys/'.concat(survey_id)
end

delete '/questions/:id/edit' do
  question = Question.find(params.fetch('id').to_i)
  question.delete
  survey_id = params.fetch('survey_id')
  redirect '/surveys/'.concat(survey_id)
end

get '/questions/:id' do
  @question = Question.find(params.fetch('id').to_i)
  @responses = @question.responses
  erb :question
end

post '/questions/:id' do
  response = Response.create({ answer: params.fetch('answer') })
  @question = Question.find(params.fetch('id').to_i)
  @question.responses << response
  @responses = @question.responses
  erb :question
end
