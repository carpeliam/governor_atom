require 'spec_helper'

module Governor
  describe ArticlesController do
    render_views
    
    before do
      @article = Factory(:article, :author => Factory(:user))
    end
    context "with an atom view" do
      before(:each) do
        get :index, :governor_mapping => :articles, :format => :atom
        assigns[:articles].should == [@article]
        response.should render_template(:index)
        response.status.should == 200 # :success
        response.should have_selector 'feed'
      end
      
      it "has a title" do
        response.should have_selector 'feed title', :content => 'Article feed'
      end
      it "has the title of the article" do
        response.should have_selector 'feed entry title', :content => 'Some article'
      end
      it "has the content of the article" do
        response.should have_selector 'feed entry content', :content => "It's about the benjis"
      end
    end
    it "only handles the index" do
      get :show, :governor_mapping => :articles, :id => @article.id, :format => :atom
      response.should_not render_template(:show)
      response.status.should == 406 # :not_acceptable
    end
  end
end