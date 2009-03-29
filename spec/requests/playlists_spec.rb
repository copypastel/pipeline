require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a playlist exists" do
  Playlist.all.destroy!
  request(resource(:playlists), :method => "POST", 
    :params => { :playlist => { :id => nil }})
end

describe "resource(:playlists)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:playlists))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of playlists" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a playlist exists" do
    before(:each) do
      @response = request(resource(:playlists))
    end
    
    it "has a list of playlists" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Playlist.all.destroy!
      @response = request(resource(:playlists), :method => "POST", 
        :params => { :playlist => { :id => nil }})
    end
    
    it "redirects to resource(:playlists)" do
      @response.should redirect_to(resource(Playlist.first), :message => {:notice => "playlist was successfully created"})
    end
    
  end
end

describe "resource(@playlist)" do 
  describe "a successful DELETE", :given => "a playlist exists" do
     before(:each) do
       @response = request(resource(Playlist.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:playlists))
     end

   end
end

describe "resource(:playlists, :new)" do
  before(:each) do
    @response = request(resource(:playlists, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@playlist, :edit)", :given => "a playlist exists" do
  before(:each) do
    @response = request(resource(Playlist.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@playlist)", :given => "a playlist exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Playlist.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @playlist = Playlist.first
      @response = request(resource(@playlist), :method => "PUT", 
        :params => { :article => {:id => @playlist.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@playlist))
    end
  end
  
end

