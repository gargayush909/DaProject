function registerOnBlockchain() {
    var ethereum_address = "your_ethereum_address";
    var password = "your_password";
  
    web3.eth.personal.newAccount(password, function (error, result) {
        if (error) {
            console.log(error);
        } else {
            console.log(result);
            alert("Registered on Blockchain! Your new Ethereum address is: " + result);
        }
    });
}

document.getElementById("registerBtn").onclick = registerOnBlockchain;
