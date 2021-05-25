Rails.application.routes.draw do


  get("/", { :controller => "pieces", :action => "index" })
  # Routes for the Comment resource:

  # CREATE
  post("/insert_comment", { :controller => "comments", :action => "create" })
          
  # READ
  get("/comments", { :controller => "comments", :action => "index" })
  
  get("/comments/:path_id", { :controller => "comments", :action => "show" })
  
  # UPDATE
  
  post("/modify_comment/:path_id", { :controller => "comments", :action => "update" })
  
  # DELETE
  get("/delete_comment/:path_id", { :controller => "comments", :action => "destroy" })

  #------------------------------

  # Routes for the Favorite resource:

  # CREATE
  post("/insert_favorite", { :controller => "favorites", :action => "create" })
          
  # READ
  get("/favorites", { :controller => "favorites", :action => "index" })
  
  get("/favorites/:path_id", { :controller => "favorites", :action => "show" })
  
  # UPDATE
  
  post("/modify_favorite/:path_id", { :controller => "favorites", :action => "update" })
  
  # DELETE
  get("/delete_favorite/:path_id", { :controller => "favorites", :action => "destroy" })

  #------------------------------

  # Routes for the Rating resource:

  # CREATE
  post("/insert_rating", { :controller => "ratings", :action => "create" })
          
  # READ
  get("/ratings", { :controller => "ratings", :action => "index" })
  
  get("/ratings/:path_id", { :controller => "ratings", :action => "show" })
  
  # UPDATE
  
  post("/modify_rating/:path_id", { :controller => "ratings", :action => "update" })
  
  # DELETE
  get("/delete_rating/:path_id", { :controller => "ratings", :action => "destroy" })

  #------------------------------

  # Routes for the Arranger resource:

  # CREATE
  post("/insert_arranger", { :controller => "arrangers", :action => "create" })
          
  # READ
  get("/arrangers", { :controller => "arrangers", :action => "index" })
  
  get("/arrangers/:path_id", { :controller => "arrangers", :action => "show" })
  
  # UPDATE
  
  post("/modify_arranger/:path_id", { :controller => "arrangers", :action => "update" })
  
  # DELETE
  get("/delete_arranger/:path_id", { :controller => "arrangers", :action => "destroy" })

  #------------------------------

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
