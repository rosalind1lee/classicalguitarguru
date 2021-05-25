Rails.application.routes.draw do



  # Routes for the Piece resource:

  # CREATE
  post("/insert_piece", { :controller => "pieces", :action => "create" })
          
  # READ
  get("/pieces", { :controller => "pieces", :action => "index" })
  
  get("/pieces/:path_id", { :controller => "pieces", :action => "show" })
  
  # UPDATE
  
  post("/modify_piece/:path_id", { :controller => "pieces", :action => "update" })
  
  # DELETE
  get("/delete_piece/:path_id", { :controller => "pieces", :action => "destroy" })

  #------------------------------

  # Routes for the Composer resource:

  # CREATE
  post("/insert_composer", { :controller => "composers", :action => "create" })
          
  # READ
  get("/composers", { :controller => "composers", :action => "index" })
  
  get("/composers/:path_id", { :controller => "composers", :action => "show" })
  
  # UPDATE
  
  post("/modify_composer/:path_id", { :controller => "composers", :action => "update" })
  
  # DELETE
  get("/delete_composer/:path_id", { :controller => "composers", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

end
