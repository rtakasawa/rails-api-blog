require 'rails_helper'

describe "PostAPI" do
  it 'すべてのポストを取得する' do
    FactoryBot.create_list(:post, 10)
    get '/api/v1/posts'
    json = JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(json['data'].length).to eq(10)
  end

  it '特定のポストを取得する' do
    post = FactoryBot.create(:post, title: 'name')
    get "/api/v1/posts/#{post.id}"
    json = JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(json['data']['title']).to eq(post.title)
  end

  it '新しいpostを作成する' do
    valid_params = { title: 'title' }

    expect { post '/api/v1/posts', params: { post: valid_params } }.to change(Post, :count).by(+1)
    expect(response.status).to eq(200)
  end
end
