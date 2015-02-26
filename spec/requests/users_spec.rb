require 'spec_helper'

describe "Users" do#0

  describe "Une inscription" do#1

    describe "ratee" do#2

      it "ne devrait pas creer un nouvel utilisateur" do#3
        lambda do#4
          visit signup_path
          fill_in :user_nom, :with => ""
          fill_in :user_email, :with => ""
          fill_in :user_password, :with => ""
          fill_in :user_password_confirmation, :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)#4
      end#3
    end#2

  describe "reussie" do#2

      it "devrait creer un nouvel utilisateurr" do#3
        lambda do#4
          visit signup_path
          fill_in :user_nom, :with => "Example User"
          fill_in :user_email, :with => "user@example.com"
          fill_in :user_password, :with => "foobar"
          fill_in :user_password_confirmation, :with => "foobar"
          click_button
          response.should have_selector("div.flash.success",
                                        :content => "Bienvenue")
          response.should render_template('users/show')
        end.should change(User, :count).by(1)#4
      end#3
    end#2
  end#1
  
  describe "identification/deconnexion" do#1

    describe "l'echec" do#2
      it "ne devrait pas identifier l'utilisateur" do#3
        visit signin_path
        fill_in "eMail",    :with => ""
        fill_in "Mot de passe", :with => ""
        click_button
        response.should have_selector("div.flash.error", :content => "Combinaison mail/mot de passe invalide.")
      end#3
    end#2

    describe "le succes" do#2
      it "devrait identifier un utilisateur puis le deconnecter" do#3
        @user = Factory(:user)
        visit signin_path
        fill_in "eMail",    :with => @user.email
        fill_in "Mot de passe", :with => @user.password
        click_button
        controller.should be_signed_in
        click_link "Deconnexion"
        controller.should_not be_signed_in
      end#3
    end#2
  end#1
end#0
