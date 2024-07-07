import { dbank_backend } from "../../declarations/dbank_backend";

async function update(){
  const currentAmt=await dbank_backend.checkBalance();
  document.getElementById("value").innerText=Math.round(currentAmt*100)/100; //current amount.

}


window.addEventListener("load", async function(){
  console.log("Finished loading");
  
  update();

});

document.querySelector("form").addEventListener("submit", async function(event){
  event.preventDefault();
  console.log("Submitted.");
  
  const button= event.target.querySelector("#submit-btn");

  const inputamt=parseFloat(document.getElementById("input-amount").value);
  const withdrawalamt=parseFloat(document.getElementById("withdrawal-amount").value);

  button.setAttribute("disabled", true);
  if(document.getElementById("input-amount").value.length!=0){
    await dbank_backend.TopUp(inputamt);
  }
  if(document.getElementById("withdrawal-amount").value.length!=0){
    await dbank_backend.Withdraw(withdrawalamt);
  }
 
  // await dbank_backend.Withdraw(withdrawalamt);

  const currentAmt=await dbank_backend.checkBalance();

  await dbank_backend.compound();

  update();//to get current amount on top


  document.getElementById("input-amount").value="";
  document.getElementById("withdrawal-amount").value="";

  button.removeAttribute("disabled");
});