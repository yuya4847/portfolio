require 'rails_helper'

RSpec.describe User, type: :model do

  it "username、email、passwordがある場合、有効であること" do
    user = FactoryBot.build(:user)
    user.valid?
    expect(user.valid?).to eq(true)
  end

  it "username、email、password、sex、profileがある場合、有効であること" do
    user = FactoryBot.build(:user, sex: "man", profile: "profile")
    user.valid?
    expect(user.valid?).to eq(true)
  end

  it "usernameがnilの場合、無効であること" do
    user = FactoryBot.build(:user, username: nil)
    user.valid?
    expect(user.valid?).to eq(false)
    expect(user.errors[:username]).to include("can't be blank")
  end

  it "emailがnilの場合、無効であること" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.valid?).to eq(false)
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "passwordがnilの場合、無効であること" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.valid?).to eq(false)
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "passwordが一致しない場合、無効であること" do
    user = FactoryBot.build(:user, password_confirmation: "passwords")
    user.valid?
    expect(user.valid?).to eq(false)
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end

  it "メールアドレスが重複する場合、無効であること" do
    user = FactoryBot.create(:user, email: "yuya@example.com")
    another_user = FactoryBot.build(:user, email: "yuya@example.com")
    another_user.valid?
    expect(another_user.valid?).to eq(false)
    expect(another_user.errors[:email]).to include("has already been taken")
  end

  it "usernameが文字数を超える場合、無効であること" do
    user = FactoryBot.build(:user, username: "a" * 21)
    user.valid?
    expect(user.valid?).to eq(false)
    expect(user.errors[:username]).to include("is too long (maximum is 20 characters)")
  end

  it "emailが文字数を超える場合、無効であること" do
    user = FactoryBot.build(:user, email: "yuya@example.com" + ( "a" * 300 ))
    user.valid?
    expect(user.valid?).to eq(false)
    expect(user.errors[:email]).to include("is too long (maximum is 255 characters)")
  end

  it "profileが文字数を超える場合、無効であること" do
    user = FactoryBot.build(:user, profile: "a" * 300)
    user.valid?
    expect(user.valid?).to eq(false)
    expect(user.errors[:profile]).to include("is too long (maximum is 255 characters)")
  end

  it "passwordが文字数に満たない場合、無効であること" do
    user = FactoryBot.build(:user, password: "a" * 5)
    user.valid?
    expect(user.valid?).to eq(false)
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end

  it "メールアドレス形式になっていない場合、無効であること" do
    user = FactoryBot.build(:user, email: "yuyaexample.com")
    user.valid?
    expect(user.valid?).to eq(false)
    expect(user.errors[:email]).to include("is invalid")
    user = FactoryBot.build(:user, email: "yuya@examplecom")
    user.valid?
    expect(user.valid?).to eq(false)
    expect(user.errors[:email]).to include("is invalid")
    user = FactoryBot.build(:user, email: "yuyaexamplecom")
    user.valid?
    expect(user.valid?).to eq(false)
    expect(user.errors[:email]).to include("is invalid")
  end

end
