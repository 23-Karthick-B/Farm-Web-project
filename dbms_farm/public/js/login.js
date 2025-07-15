
let signup = document.querySelector(".signup");
let login = document.querySelector(".login");
let slider = document.querySelector(".slider");
let formSection = document.querySelector(".form-section");
const loginForm = document.querySelector('.login-form')
const signupForm = document.querySelector('.signup-form')


function checkUserFields(fieldsData) {
    const { choice, formType, username, password, name, contact,
        pincode, street, district, "confirm-pass": confirmPass } = fieldsData;
    if (formType === "login") {
        // Process login data only
        //check with databases ?????
        console.log("Login Data:", { choice, username, password });
        if (choice == undefined) {
            //alert with ???
            alert('select farmer or user')
            return 0
        }
        if (!(username.length && password.length)) {
            alert('some of the fields are not filled')
            return 0
        }

    } else if (formType === "signup") {
        // Process signup data only
        console.log("Signup Data:", { choice, username, name, contact, password, confirmPass });

        if (choice == undefined) {
            //alert with ???
            alert('select farmer or user')
            return 0
        }
        if (!(username.length && name.length && contact.length && password.length && confirmPass.length && district.length && street.length)) {
            alert('some of the fields are not filled')
            return 0
        }

        if (contact.length !== 10) {
            ///do alert ???? 
            console.log('contact length should be 10');
            alert('contact should consist 10 numbers')
            return 0
        }
        if (pincode.length !== 6) {
            ///do alert ???? 
            console.log('pincode should be 6 digits');
            alert('pincode should be 6 digits')
            return 0
        }
        if (!(password === confirmPass)) {
            alert("passwords not matching")
            return 0
        }


    }
    return 1
}


async function formClicked(e) {
    e.preventDefault()
    formdata = new FormData(e.target)
    let formObject = Object.fromEntries(formdata.entries());
    let isfieldOk = checkUserFields(formObject)
    if (!isfieldOk) {
        return
    }
    try {
        const response = await fetch('/', {
            method: 'POST',
            headers: {
                'content-type': 'application/json'
            },
            body: JSON.stringify(formObject)
        })

        const data = await response.json();
        console.log("datas : " + data);
        if (data.alertMessage) {
            alert(data.alertMessage)
        }
        else if (data.redirect) {
            window.location.assign(data.redirect)
        }
    } catch (error) {
        console.log(`error : ${error}`);
    }

}


function intEventListners() {
    signup.addEventListener("click", () => {
        slider.classList.add("moveslider");
        formSection.classList.add("form-section-move");
    });

    login.addEventListener("click", () => {
        slider.classList.remove("moveslider");
        formSection.classList.remove("form-section-move");
    });

    loginForm.addEventListener('submit', formClicked);
    signupForm.addEventListener('submit', formClicked);
}

document.addEventListener('DOMContentLoaded', intEventListners)

