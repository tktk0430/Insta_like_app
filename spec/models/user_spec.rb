require 'rails_helper'

RSpec.describe User, type: :model do

  it "is valid with a first name, email, account, and password" do
    user=User.new(
      name:"test",
      account:"tester",
      email:"tester@gmail.com",
      password: "hogehoge",
      password_confirmation: "hogehoge"
    )
    expect(user).to be_valid
  end

  it "is invalid without name" do
    user=User.new(name:nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "is invalid with too long name" do
    user=User.new(name:"a"*21)
    user.valid?
    expect(user.errors[:name]).to include("は20文字以内で入力してください")
  end

  it "is invalid without account" do
    user=User.new(account:nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "is invalid with duplicated account" do
    User.create(
      name:"test",
      account:"tester",
      email:"tester@gmail.com",
      password: "hogehoge",
      password_confirmation: "hogehoge"
    )
    user=User.new(
      name:"test-second",
      account:"tester",
      email:"tester-second@gmail.com",
      password: "hogehoge",
      password_confirmation: "hogehoge"
    )
    user.valid?
    expect(user.errors[:account]).to include("はすでに存在します")
  end

  it "is invalid without password" do
    user=User.new(
      name:"test",
      account:"tester",
      email:"tester@gmail.com",
      password: "",
      password_confirmation: "hogehoge"
    )
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it "is invalid without email" do
    user=User.new(
      name:"test",
      account:"tester",
      email:"",
      password: "hogehoge",
      password_confirmation: "hogehoge"
    )
    user.valid?
    expect(user.errors[:email]).to include "を入力してください"
  end

  it "is invalid with duplicated email" do
    User.create(
      name:"test",
      account:"tester",
      email:"tester@gmail.com",
      password: "hogehoge",
      password_confirmation: "hogehoge"
    )
    user=User.new(
      name:"test-second",
      account:"tester-second",
      email:"tester@gmail.com",
      password: "hogehoge",
      password_confirmation: "hogehoge"
    )
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

  it "is invalid with duplicated email" do
    invalid_emails=%w(@@@gmail.com hogehogegmail.com hoge@gmail)
    invalid_emails.each do |email|
      user=User.new(email:email)
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end
  end

  it "is invalid with too long email" do
    user=User.new(email:"a"*201+"@gmail.com")
    user.valid?
    expect(user.errors[:email]).to include("は200文字以内で入力してください")
  end

  it "is invalid with too long introduction" do
    user=User.new(introduction:"a"*241)
    user.valid?
    expect(user.errors[:introduction]).to include("は240文字以内で入力してください")
  end

  it "create a notification from user to other" do
    user=User.create(
      name:"test",
      account:"tester",
      email:"tester@gmail.com",
      password: "hogehoge",
      password_confirmation: "hogehoge"
    )
    other=User.create(
      name:"other",
      account:"other",
      email:"other@gmail.com",
      password: "hogehoge",
      password_confirmation: "hogehoge"
    )
    other.create_notification_by(user)
    notif=Notification.find_by(visiter_id:user.id,visited_id:other.id)
    expect(notif).not_to be_nil
  end
end
