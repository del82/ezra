require 'spec_helper'

describe TargetsController do

  context "unauthenticated"  do
    pending "should not allow access to GET #index"
    pending "should not allow access to GET #show"
    pending "should not allow access to GET #new"
    pending "should not allow access to POST #create"
    pending "should not allow access to GET #edit"
    pending "should not allow access to PUT #update"
    pending "should not allow access to DELETE #destroy"
  end
  
  context "authenticated as user" do
    pending "should allow access to GET #index"
    pending "should allow access to GET #show"
    pending "should not allow access to GET #new"
    pending "should not allow access to POST #create"
    pending "should not allow access to GET #edit"
    pending "should not allow access to PUT #update"
    pending "should not allow access to DELETE #destroy"
  end

  context "authenticated as admin" do
    pending "should allow access to GET #index"
    pending "should allow access to GET #show"
    pending "should allow access to GET #new"
    pending "should allow access to POST #create"
    pending "should allow access to GET #edit"
    pending "should allow access to PUT #update"
    pending "should allow access to DELETE #destroy"
  end

end
