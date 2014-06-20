# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Notification do
  before(:each) do
    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)
  end
  
  it "发送提醒" do
    n = @user1.notifications.build({ receiver_names: "#{@user1.name} #{@user2.name} #{@user3.name}", content: 'content' })
    n.send_notifications.should be_true
    Notification.count.should == 3
  end
end
