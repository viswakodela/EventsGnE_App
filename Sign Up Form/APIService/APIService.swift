//
//  APIService.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/16/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit
import Alamofire
import FacebookCore
import CoreLocation

class APIService {
    
    static let shared = APIService()
    
    //To get access token
    func getAccessToken(completion: @escaping (String) -> ()) {
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        let params = ["grant_type": "password", "username": "viswaKodela", "password" : "viswa321#!!"]
        
        let tokenUrl = "http://eventswebapi2.us-east-2.elasticbeanstalk.com/token"
        
        Alamofire.request(tokenUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers).responseData { (dataResponse) in
            guard let data = dataResponse.data else {return}
            let accessTokenData = try? JSONDecoder().decode(AccesToken.self, from: data)
            if let accessToken = accessTokenData?.access_token {
                completion(accessToken)
            }
        }
    }
    
    //To login User
    func loginAuthenticationwithAccessToken(accessToken: String, email: String, password: String, completion: @escaping (User?, Error?) -> ()) {
        let headers = ["Content-Type": "application/x-www-form-urlencoded", "Authorization": "Bearer " + accessToken]
        let params = ["email": email, "password" : password]
        let loginURL = "http://eventswebapi2.us-east-2.elasticbeanstalk.com/api/v1/Login"
        
        Alamofire.request(loginURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseData { (dataResponse) in
            guard let data = dataResponse.data else {return}
            let dummyString = String(data: data, encoding: .utf8)
            print(dummyString ?? "")
            
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                completion(user, nil)
            } catch let err {
                completion(nil, err)
            }
        }
    }
    
    //To register User
    func regidsterUserwith(firstName: String, lastName: String, email: String, password: String, repeatPassword: String, completion: @escaping (String) -> ()) {
        
        APIService.shared.getAccessToken { (accessToken) in
            let registerUserURL = "http://eventswebapi2.us-east-2.elasticbeanstalk.com/api/v1/RegisterProfile"
            let headers = ["Content-Type": "application/x-www-form-urlencoded", "Authorization": "Bearer " + accessToken]
                
            let params: Parameters = [
                "FirstName": firstName,
                "LastName": lastName,
                "Email": email,
                "Password": password,
                "RepeatPassword": repeatPassword
            ]
            
            Alamofire.request(registerUserURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers).responseJSON(completionHandler: { (dataResponse) in
                guard let data = dataResponse.data else {return}
                guard let returnValue = String(data: data, encoding: .utf8) else {return}
                completion(returnValue)
            })
        }
    }
    
    
    //Code Verification
    func verificationCodeforSignUp(email: String, passwod: String, verificationCode: String, completion: @escaping (_ booleanValue: String?, _ user: User?, _ alert: UIAlertController?) -> ()) {
        
        APIService.shared.getAccessToken { (accessToken) in
            
            //TO confirm the user enterd verification code is correct or not.
            let verificationCodeUrl = "http://eventswebapi2.us-east-2.elasticbeanstalk.com/api/v1/ConfirmationCode"
            let params = ["email" : email,
                          "code" : verificationCode]
            let headers = ["Content-Type" : "application/x-www-form-urlencoded",
                           "Authorization": "Bearer " + accessToken]
            
            Alamofire.request(verificationCodeUrl, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseData { (dataResponse) in
                
                guard let data = dataResponse.data else {return}
                let returnValue = String(data: data, encoding: .utf8)
                
                if returnValue == "true" {
                    
                    APIService.shared.loginAuthenticationwithAccessToken(accessToken: accessToken, email: email, password: passwod, completion: { (user, err) in
                        
                        if let error = err {
                            print(error.localizedDescription)
                        }
                        completion(returnValue, user, nil)
                    })
                } else {
                    //User entered Code is Wrong
                    
                    print("User entered the wrong Code")
                    
                    let alert = UIAlertController(title: "Wrong Verification Code", message: "Wrong confirmation code. Please try again!", preferredStyle: .alert)
                    let okeAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okeAction)
                    completion(nil, nil, alert)
                }
            }
        }
    }
    
    //Forget password
    func forgetPassword(email: String, completion: @escaping (_ alert: UIAlertController?, _ email: String?, _ accessToken: String?) -> ()) {
        
        APIService.shared.getAccessToken { (accessToken) in
            
            let forgetPasswordURL = "http://eventswebapi2.us-east-2.elasticbeanstalk.com/api/v1/ForgotPassword"
            
            let params = ["email": email]
            let headers = ["Content-Type" : "application/x-www-form-urlencoded",
                           "Authorization": "Bearer " + accessToken
            ]
            
            Alamofire.request(forgetPasswordURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseData(completionHandler: { (dataResponse) in
                
                guard let data = dataResponse.data else {return}
                let returnValue = String(data: data, encoding: .utf8)
                print(returnValue ?? "")
                if returnValue == "\"Email Not Sent!!\"" {
                    let alert = UIAlertController(title: "Something went wrong", message: "Please check your email", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    completion(alert, nil, nil)
                } else if returnValue == "\"Email Sent!!\"" {
                    let alert = UIAlertController(title: "Verification code Sent", message: "An email with the verification code has been sent to your email, please check", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    completion(alert, email, accessToken)
                }
            })
        }
    }
    
    
    //Verify code received for Forget password
    func verifycodeForForgetPassword(email: String, code: String, accessToken: String, completion: @escaping (_ alert: UIAlertController?, _ email: String?, _ accessToken: String?) -> ()) {
        
        let verifyCodeURL = "http://eventswebapi2.us-east-2.elasticbeanstalk.com/api/v1/ConfirmationCode"
        let params: Parameters = ["email" : email,
                                  "code" : code
                                ]
        let headers = ["Content-Type" : "application/x-www-form-urlencoded",
                       "Authorization": "Bearer " + accessToken
                    ]
        
        Alamofire.request(verifyCodeURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseData { (dataResp) in
            guard let data = dataResp.data else {return}
            let returnValue = String(data: data, encoding: .utf8)
            
            if returnValue == "true" {
                let alert = UIAlertController(title: "Successful..!", message: "Verification successful", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                completion(alert, email, accessToken)
            } else {
                //Show Alert saying user entered wrong Code
                let alert = UIAlertController(title: "Wrong Code", message: "Please enter the correct verification code", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                completion(alert, nil, nil)
            }
        }
    }
    
    //Entering New Password 
    func enterNewPassword(newPassword: String, retypedPassword: String, email: String, accessToken: String, completion: @escaping (_ boolValue: String?) -> ()) {
        
        let newPasswordURL = "http://eventswebapi2.us-east-2.elasticbeanstalk.com/api/v1/Password"
        let params: Parameters = [
                                    "Password": newPassword,
                                    "RepeatPassword": retypedPassword,
                                    "Email": email
                                ]
        let headers = ["Content-Type" : "application/x-www-form-urlencoded",
                       "Authorization": "Bearer " + accessToken
                    ]
        
        Alamofire.request(newPasswordURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers).responseData { (dataResponse) in
            
            guard let data = dataResponse.data else {return}
            guard let boolValue = String(data: data, encoding: .utf8) else {return}
            
            completion(boolValue)
        }
    }
    
    //Facebook login
    func loginWithFacebook(accessToken: String, completion: @escaping (User?, Error?) -> ()) {
        if let fb_accessToken = AccessToken.current {
            let headers = [
                "Authorization": "Bearer " + accessToken,
                "Content-Type": "application/x-www-form-urlencoded"
            ]
            let params: Parameters = ["facebookToken": fb_accessToken.authenticationToken]
            print(fb_accessToken.authenticationToken)
            
            let faceBookURL = "http://eventswebapi2.us-east-2.elasticbeanstalk.com/api/v1/FacebookLogin"
            
            
            Alamofire.request(faceBookURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (dataResp) in
                guard let data = dataResp.data else {return}
                do {
                    let fbUser = try JSONDecoder().decode(FBUser.self, from: data)
                    
                    let user = fbUser.MainUser
                    completion(user, nil)
                } catch {
                    completion(nil, error)
                }
            }
        }
    }
    
    
    //Home Feed fetch
    func fetchHomeFeedData(lattitude: CLLocationDegrees, longitude: CLLocationDegrees, searchText: String?, page: Int?, completion: @escaping ([Event]?, Error?) -> ()) {
        
        let latitude = String(lattitude)
        let longitude = String(longitude)
        
        let postURL = "http://eventswebapi2.us-east-2.elasticbeanstalk.com/api/v1/Events"
        let params: Parameters = ["latitude" : latitude,
                                  "longitude" : longitude,
                                  "nearby" : 1000,
                                  "page" : page ?? 1,
                                  "name" : searchText ?? ""]
        
        APIService.shared.getAccessToken { (accessToken) in
            
            let headers = ["Content-Type" : "application/x-www-form-urlencoded",
                           "Authorization": "Bearer " + accessToken
            ]
            
            Alamofire.request(postURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler: { (dataResp) in
//                print(dataResp)
                guard let data = dataResp.data else {return}
                
                do {
                    let allEvents = try JSONDecoder().decode([Event].self, from: data)
                    completion(allEvents, nil)
                } catch {
                    completion(nil, error)
                }
            })
        }
    }
}
