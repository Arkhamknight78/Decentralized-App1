import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank
{ //class or cannister
  stable var currentValue: Float = 3000; 
  //stable keyword protects against resets of value when dfx is re-deployed.//
  stable var startTime= Time.now();
  startTime := Time.now();
  Debug.print(debug_show(startTime));

  // currentValue:=1000; //replace ':='
  let id=928984094209; //immutable data declaration 
  // Debug.print(debug_show(currentValue));
  // Debug.print(debug_show(id));
public func TopUp(amount: Float){
    currentValue+=amount;
    // Debug.print("After Update");
    Debug.print(debug_show(currentValue));

  };
public func Withdraw(amount: Float){
  var temp:Float=currentValue-amount;
  if( temp>=0){
    currentValue-=amount;
    Debug.print("After Update");
    Debug.print(debug_show(currentValue));}
    else{
      Debug.print("Withdrawal more than currentValue");
    }

  };

  public query func checkBalance(): async Float {
    return currentValue;
  }; 

  public func compound(){
    let currentTime=Time.now();
    let timeElapsed_ns=currentTime-startTime;
    let timeElapsed_s=timeElapsed_ns/1000000000;

    currentValue := currentValue*( 1.01 ** Float.fromInt(timeElapsed_s));
    startTime:=currentTime
  }

}